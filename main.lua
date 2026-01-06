function love.load()
    -- Config
    Config = require('config')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    flipped = false
    math.randomseed(os.clock())

    -- Libraries
    Bump = require('libs.bump')
    Object = require('libs.classic')
    Timer = require('libs.timer')
    Camera = require('libs.camera')

    -- Classes
    Plr = require('classes.Player')

    -- Code Chunks
    ObstacleHandler = require('obstacleHandler')

    -- Shaders
    InvertShader = love.graphics.newShader('res/shaders/invert.glsl')

    -- Objects
    World = Bump.newWorld(16)

    Player = Plr(Config.BASE_WIDTH / 2 - 8, Config.BASE_HEIGHT / 2 - 8, 'res/img/Player-placeholder.png')

    -- Wall
    local leftWall = { isWall = true }
    local rightWall = { isWall = true }

    World:add(leftWall, 0, 0, 8, Config.BASE_HEIGHT)
    World:add(rightWall, Config.BASE_WIDTH-8, 0, 8, Config.BASE_HEIGHT)

    WallImageLeft = love.graphics.newImage('res/img/Wall-left.png')
    WallImageRight = love.graphics.newImage('res/img/Wall-right.png')

    -- Timers
    ObstacleTimer = Timer()
    spawnNewObstacle()
end

function love.update(dt)
    Player:update(dt)
    Timer.update(dt)
    ObstacleTimer:update(dt)
    ObstacleHandler:update(dt)
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
    ObstacleHandler:draw()
end