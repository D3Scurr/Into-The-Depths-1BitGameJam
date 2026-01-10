local Player = Object:extend()
local GameOver = require('game-over')

local disableBunk = false
local bunkWasPressed = false

local committedChargeDirectionX = 0
local directionCommited = false

function Player:new(x, y, image)
    self.x, self.y = x, y
    self.baseX, self.baseY = x, y
    self.vx, self.vy = 0, 0
    self.width, self.height = 16, 16
    self.image = love.graphics.newImage(image)
    self.horizontalSpeed = 70
    self.downSpeed, self.upSpeed, self.chargeSpeed = 100, 200, 150
    self.isPlayer = true

    self.health = 3
    self.score = 0

    -- Bunk values
    self.isBunk = false
    self.bunkDuration = 1
    self.bunkPoints = 2
    self.bunkPointsCap = 3

    self.bunkMeter = 0
    self.bunkCap = 100

    World:add(self, self.x, self.y, self.width, self.height)
end

function Player:reset()
    self.score = 0
    self.health = 3
    self.x, self.y = self.baseX, self.baseY
    self.vx, self.vy = 0, 0
    
    self.isBunk = false
    self.bunkPoints = 2
    self.bunkMeter = 0
end

local function resolveCollisions(self, cols, len)
    for i = 1, len do
        local col = cols[i]

        -- Horizontal contact
        if col.type == 'slide' then
            if col.normal.x ~= 0 then
                self.vx = 0
                self.isBunk = false
            end
        end

        if col.type == 'cross' then
            if col.normal.x ~= 0 and self.isBunk then
                self.bunkPoints = self.bunkPoints + 1
            end
        end
    end
end

local ObjectFilter = function (item, other)
    if other.isObstacle then return 'cross'
    elseif other.isWall then return 'slide'
    end
end

local function move(self, dt)
    -- Bump world

    local goalX = self.x + self.vx * dt;
    local goalY = self.y + self.vy * dt;

    local actualX, actualY, cols, len = World:move(self, goalX, goalY, ObjectFilter)

    self.x, self.y = actualX, actualY

    resolveCollisions(self, cols, len)
end

local function handleLeft(self)
    self.vx = -self.horizontalSpeed
end

local function handleRight(self)
    self.vx = self.horizontalSpeed
end

local function handleUp(self)
    self.vy = -self.upSpeed
end

local function handleDown(self)
    self.vy = self.downSpeed
end

local function handleCharge(self)
    self.vx = self.chargeSpeed * committedChargeDirectionX
end

local function stopHorizontal(self)
    self.vx = 0
end

local function stopVertical(self)
    self.vy = 0
end

local function handleBunk(self)
    self.isBunk = true
    self.bunkPoints = self.bunkPoints - 1
    disableBunk = true
    BunkTimer:during(self.bunkDuration, function()
        
    end, function()
        self.isBunk = false
        disableBunk = false
        directionCommited = false
    end)
end

local function handleInputs(self)
    local left = love.keyboard.isDown('left')
    local right = love.keyboard.isDown('right')
    local up = love.keyboard.isDown('up')
    local down = love.keyboard.isDown('down')
    local bunk = love.keyboard.isDown('space')

    if bunk and not disableBunk and not bunkWasPressed and self.bunkPoints > 0 then
        handleBunk(self)
    end

    if self.isBunk and not directionCommited then
        if left and not right then
            committedChargeDirectionX = -1
            directionCommited = true
        elseif right and not left then
            committedChargeDirectionX = 1
            directionCommited = true
        else
            committedChargeDirectionX = 0
        end
    end
    
    if not self.isBunk then
        if left and not right then
            handleLeft(self)
        elseif right and not left then
            handleRight(self)
        else
            stopHorizontal(self)
        end
    else
        if committedChargeDirectionX ~= 0 then
            handleCharge(self)
        end
    end

    if up and not down and self.y > 32 then
        handleUp(self)
    elseif down and not up and self.y < 80 then
        handleDown(self)
    else
        stopVertical(self)
    end
end

local function statCheck(self)
    if self.health <= 0 then
        if self.score > HighScore then
            HighScore = self.score
        end
        Gamestate.switch(GameOver)
    end

    if self.bunkMeter >= 100 and self.bunkPoints < self.bunkPointsCap then
        self.bunkMeter = 0
        self.bunkPoints = self.bunkPoints + 1
    end

    if self.bunkPoints >= self.bunkPointsCap then
        self.bunkMeter = 0
    end
end

function Player:update(dt)
    move(self, dt)
    handleInputs(self)
    statCheck(self)
    bunkWasPressed = love.keyboard.isDown('space')
end

function Player:draw()
    if self.isBunk then flipColors() end
    love.graphics.draw(self.image, self.x, self.y)
    if self.isBunk then flipColors() end
end

return Player