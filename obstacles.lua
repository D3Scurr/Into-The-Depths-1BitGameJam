local obstacles = {
    {
        type = 1,
        name = 'block',
        warnImage = love.graphics.newImage('res/img/Warn-block.png'),
        image = love.graphics.newImage('res/img/Obstacle-box.png'),
        speed = 100,
        height = 16, width = 16,
        isObstacle = true,
        bunkCharge = 15
    },
    {
        type = 2,
        name = 'log',
        warnImage = love.graphics.newImage('res/img/Warn-log.png'),
        image = love.graphics.newImage('res/img/Log.png'),
        speed = 70,
        height = 16, width = 64,
        isObstacle = true,
        bunkCharge = 10
    },
    {
        type = 3,
        name = 'slab',
        warnImage = love.graphics.newImage('res/img/Warn-block.png'),
        image = love.graphics.newImage('res/img/Slab.png'),
        speed = 200,
        height = 8, width = 16,
        isObstacle = true,
        bunkCharge = 20
    }
}

return obstacles