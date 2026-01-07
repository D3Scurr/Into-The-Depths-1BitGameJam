local game = require('game')
local GameOver = require('game-over')

function love.load()
    -- Config
    HighScore = 0
    Config = require('config')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    flipped = false
    -- love.graphics.setNewFont('8-bit Arcade In.ttf')

    math.randomseed(os.clock())

    Ui = require('ui')

    -- Libraries
    Bump = require('libs.bump')
    Camera = require('libs.camera')
    Gamestate = require('libs.gamestate')
    Object = require('libs.classic')
    Timer = require('libs.timer')

    -- Classes
    Plr = require('classes.Player')

    -- Code Chunks
    ObstacleHandler = require('obstacleHandler')

    -- Shaders
    InvertShader = love.graphics.newShader('res/shaders/invert.glsl')

    -- Objects
    World = Bump.newWorld(16)
    Player = Plr(Config.BASE_WIDTH / 2 - 8, Config.BASE_HEIGHT / 2 - 8, 'res/img/Player-placeholder.png')

    Gamestate.registerEvents()
    Gamestate.switch(game)
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
    
    if key == 'r' and Gamestate.current() == GameOver then
        Gamestate.switch(game)
    end
end