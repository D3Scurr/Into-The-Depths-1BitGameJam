local Config = require('config')

function love.conf(t)
	t.console = true
    t.window.title = "Into the depths"
    t.window.width = Config.WINDOW_WIDTH
    t.window.height = Config.WINDOW_HEIGHT
end