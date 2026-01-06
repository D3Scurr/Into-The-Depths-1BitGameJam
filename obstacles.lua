local Config = require('config')

local obstacles = {
    {
        type = 1,
        name = 'box',
        warnImage = love.graphics.newImage('res/img/Warn-block.png'),
        image = love.graphics.newImage('res/img/Obstacle-box.png'),
        speed = 100,
        height = 16, width = 16
    }
}

return obstacles