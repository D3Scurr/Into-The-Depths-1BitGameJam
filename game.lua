local game = { }

local bunkAdd = 2

function game:init()
    -- Wall
    local leftWall = { isWall = true }
    local rightWall = { isWall = true }

    World:add(leftWall, 0, 0, 8, Config.BASE_HEIGHT)
    World:add(rightWall, Config.BASE_WIDTH-8, 0, 8, Config.BASE_HEIGHT)

    WallImageLeft = love.graphics.newImage('res/img/Wall-left.png')
    WallImageRight = love.graphics.newImage('res/img/Wall-right.png')

    Cam = Camera()
end

function game:enter()
    ObstacleHandler:reset()
    Player:reset()

    -- Timers
    BunkTimer = Timer()
    BunkMeterTimer = Timer()
    ObstacleTimer = Timer()
    ScoreTimer = Timer()
    ShakeTimer = Timer()

    BunkMeterTimer:every(0.2, function ()
        if (Player.bunkMeter < Player.bunkCap) and (Player.bunkPoints < Player.bunkPointsCap) then
            Player.bunkMeter = Player.bunkMeter + bunkAdd
            print(Player.bunkMeter)
        end
    end)

    ScoreTimer:every(0.1, function()
        Player.score = Player.score + 1
    end)

    ScoreTimer:every(10, function()
        ObstacleSpeedMult = ObstacleSpeedMult + ObstacleSpeedAdd
        ObstacleSpeedAdd = ObstacleSpeedAdd * 1.2

        ObstacleSpawnMult = ObstacleSpawnMult + ObstacleSpawnAdd
        ObstacleSpeedAdd = ObstacleSpawnAdd * 2
    end)

    spawnNewObstacle()
end

function ScreenShake()
    local orig_x, orig_y = Cam:position()
    ShakeTimer:during((Player.isBunk and 0.5 or 0.8), function()
        Cam:lookAt(orig_x + math.random(-2,2), orig_y + math.random(-2,2))
    end, function()
        -- reset Camera position
        Cam:lookAt(orig_x, orig_y)
    end)
end

local function updateTimers(dt)
    Timer.update(dt)
    BunkTimer:update(dt)
    BunkMeterTimer:update(dt)
    ScoreTimer:update(dt)
    ShakeTimer:update(dt)
    ObstacleTimer:update(dt)
end

function game:update(dt)
    Cam:lookAt(Config.WINDOW_WIDTH/2, Config.WINDOW_HEIGHT/2)

    updateTimers(dt)

    Player:update(dt)

    ObstacleHandler:update(dt)
end

-- * game:draw * --

local function drawWalls()
    love.graphics.draw(WallImageLeft, 0, 0)
    love.graphics.draw(WallImageRight, Config.BASE_WIDTH-8, 0)
end

function game:draw()
    Cam:attach()
        love.graphics.scale(Config.SCALE, Config.SCALE)
        drawWalls()
        Player:draw()
        ObstacleHandler:draw()
        Ui:draw()
    Cam:detach()
end

return game