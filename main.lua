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

    Player = Plr(32, 32, 'res/img/Player-placeholder.png', World)
end

function love.update(dt)
    Player:update(dt)
end

function love.draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    Player:draw()
end