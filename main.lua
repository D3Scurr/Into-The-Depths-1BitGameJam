game = require('game')
GameOver = require('game-over')
pause = require('pause')
menu = require('menu')

Paused = false

function love.load()
    -- Config
    Config = require('config')
    HighScore = 0
    love.graphics.setDefaultFilter('nearest', 'nearest')
    flipped = false
    love.graphics.setNewFont('PressStart2P.ttf')

    math.randomseed(os.clock())

    Ui = require('ui')

    -- Libraries
    anim8 = require('libs.anim8')
    Bump = require('libs.bump')
    Camera = require('libs.camera')
    Gamestate = require('libs.gamestate')
    Object = require('libs.classic')
    Timer = require('libs.timer')

    -- Sounds
    sounds = {}

    sounds.theme = love.audio.newSource('res/sound/Bunkin.mp3', 'stream')
    sounds.theme:setVolume(0.5)
    sounds.theme:setLooping(true)

    sounds.bunk = love.audio.newSource('res/sound/Bunk.wav', 'static' )
    sounds.destroy = love.audio.newSource('res/sound/Destroy.wav', 'static')
    sounds.gainBunk = love.audio.newSource('res/sound/GainBunk.wav', 'static')
    sounds.hit = love.audio.newSource('res/sound/Hit.wav', 'static')
    sounds.pause = love.audio.newSource('res/sound/pause.wav', 'static')
    sounds.unPause = love.audio.newSource('res/sound/unpause.wav', 'static')
    
    -- Classes
    Plr = require('classes.Player')

    -- Code Chunks
    ObstacleHandler = require('obstacleHandler')

    -- Shaders
    InvertShader = love.graphics.newShader('res/shaders/invert.glsl')

    -- Objects
    World = Bump.newWorld(16)
    Player = Plr(Config.BASE_WIDTH / 2 - 8, Config.BASE_HEIGHT / 2 - 8, 'res/img/Player.png', 'res/img/Falling-trail.png', 'res/img/Bunk-animation.png')

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.keypressed(key)
    if key == 's' and Gamestate.current() == menu then
        Gamestate.push(settings)
    end

    if key == 'p' then
        if Gamestate.current() == game then
            Gamestate.push(pause)
        elseif Gamestate.current() == pause then
            Gamestate.pop(pause)
        elseif Gamestate.current() == menu then
            Gamestate.switch(game)
        end
        
    end

    if key == 'r' then
        Gamestate.switch(game)
    end
end