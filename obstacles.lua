local obstacles = {
    {
        type = 1,
        name = 'block',
        warnImage = love.graphics.newImage('res/img/Warn-block.png'),
        image = love.graphics.newImage('res/img/Obstacle-box.png'),
        speed = 100,
        height = 16, width = 16,
        isObstacle = true
    },
    {
        type = 2,
        name = 'log',
        warnImage = love.graphics.newImage('res/img/Warn-log.png'),
        image = love.graphics.newImage('res/img/Log.png'),
        speed = 50,
        height = 16, width = 64,
        isObstacle = true
    },
    {
        type = 3,
        name = 'log',
        warnImage = love.graphics.newImage('res/img/Warn-log.png'),
        image = love.graphics.newImage('res/img/Log.png'),
        speed = 50,
        height = 16, width = 64,
        isObstacle = true
    }
}

return obstacles