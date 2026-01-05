Player = Object:extend()

function Player:new(x, y, image, World)
    self.x, self.y = x, y
    self.vx, self.vy = 0, 0
    self.width, self.height = 16, 16
    self.image = love.graphics.newImage(image)
    self.speed = 100

    World:add(self, self.x, self.y, self.width, self.height)
end

local function resolveCollisions(self, cols, len)
    for i = 1, len do
        local col = cols[i]

        -- Horizontal contact
        if col.normal.x ~= 0 then
            -- Collision
            self.vx = 0
        end
    end
end

local function move(self, dt)
    -- Bump world

    local goalX = self.x + self.vx * dt;
    local goalY = self.y + self.vy * dt;

    local actualX, actualY, cols, len = World:move(self, goalX, goalY) -- need to resolve collsions

    self.x, self.y = actualX, actualY
    
    self.onGround = false
    self.onLamp = false

    resolveCollisions(self, cols, len)
end

local function handleLeft(self)
    self.vx = -self.speed
end

local function handleRight(self)
    self.vx = self.speed
end

local function stop(self)
    self.vx = 0
end

local function handleInputs(self)
    local left = love.keyboard.isDown('left')
    local right = love.keyboard.isDown('right')

    if left and not right then
        handleLeft(self)
    elseif right and not left then
        handleRight(self)
    else
        stop(self)
    end
end

function Player:update(dt)
    move(self, dt)
    handleInputs(self)
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player