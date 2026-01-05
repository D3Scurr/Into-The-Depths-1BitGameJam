function love.load()
    -- Config
    Config = require('config')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    flipped = false
    math.randomseed(os.clock())

    -- Libraries
    Bump = require('libs.bump')
    Object = require('libs.classic')

    -- Classes
    Plr = require('classes.Player')

    -- Shaders
    InvertShader = love.graphics.newShader('res/shaders/invert.glsl')

    -- Objects
    World = Bump.newWorld(16)

    Player = Plr(Config.BASE_WIDTH / 2 - 8, Config.BASE_HEIGHT / 2 - 8, 'res/img/Player-placeholder.png', World)

    -- Wall
    local leftWall = {}
    local rightWall = {}

    World:add(leftWall, 0, 0, 8, Config.BASE_HEIGHT)
    World:add(rightWall, Config.BASE_WIDTH-8, 0, 8, Config.BASE_HEIGHT)

    WallImageLeft = love.graphics.newImage('res/img/Wall-left.png')
    WallImageRight = love.graphics.newImage('res/img/Wall-right.png')

    -- Timers
    Timer = {
        ObstacleWait = 0,
        ObstacleOnScreen = 0
    }

    -- Obstacles
    Obstacle = {
        width = 16,
        height = 16
    }

    Obstacle.x = math.random(9, Config.BASE_WIDTH - 8 - Obstacle.width)

    ObstacleList = {}

    WarnImage = love.graphics.newImage('res/img/Warn-block.png')
    ObstacleImage = love.graphics.newImage('res/img/Obstacle-box.png')
end

function love.update(dt)
    Player:update(dt)
    Timer.ObstacleWait = Timer.ObstacleWait + dt
    if Timer.ObstacleWait >= 2 then
        Timer.ObstacleOnScreen = Timer.ObstacleOnScreen + dt
    end
end

local function drawWalls()
    love.graphics.draw(WallImageLeft, 0, 0)
    love.graphics.draw(WallImageRight, Config.BASE_WIDTH-8, 0)
end

function flipColors()
    if not flipped then
        love.graphics.setShader(InvertShader)
        flipped = true
    else
        love.graphics.setShader()
        flipped = false
    end
end

function love.keypressed(key)
    if key == 'f' then
        flipColors()
    end
end

function love.draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    drawWalls()
    Player:draw()
    if Timer.ObstacleWait >= 2 then
        if Timer.ObstacleOnScreen < 2 then
            love.graphics.draw(ObstacleImage, Obstacle.x, Config.BASE_HEIGHT - 16)
        else
            Timer.ObstacleWait = 0
            Timer.ObstacleOnScreen = 0
            Obstacle.x = math.random(9, Config.BASE_WIDTH-8-Obstacle.width)
        end
    else
        love.graphics.draw(WarnImage, Obstacle.x, Config.BASE_HEIGHT - 16)
    end
end