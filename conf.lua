local Config = require('config')

function love.conf(t)
    t.console = false
    t.window.title = "Bunk!"
    t.window.width = Config.WINDOW_WIDTH
    t.window.height = Config.WINDOW_HEIGHT
end