function love.load()
    -- Config
    Config = require('config')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Libraries
    Bump = require('libs.bump')
    Object = require('libs.classic')

    -- Classes
    Plr = require('classes.Player')

    -- Objects
    World = Bump.newWorld(16)

    Player = Plr(64, 64, 'res/img/Player-placeholder.png', World)

    -- Wall
    local leftWall = {}
    local rightWall = {}

    World:add(leftWall, 0, 0, 8, Config.BASE_HEIGHT)
    World:add(rightWall, Config.BASE_WIDTH-8, 0, 8, Config.BASE_HEIGHT)

    WallImageLeft = love.graphics.newImage('res/img/Wall-left.png')
    WallImageRight = love.graphics.newImage('res/img/Wall-right.png')
end

function love.update(dt)
    Player:update(dt)
end

local function drawWalls()
    love.graphics.draw(WallImageLeft, 0, 0)
    love.graphics.draw(WallImageRight, Config.BASE_WIDTH-8, 0)
end

function love.draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    drawWalls()
    Player:draw()
end