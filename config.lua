-- Global configuration variables
local Config = {
    -- Base resolution
    BASE_WIDTH = 128,
    BASE_HEIGHT = 128,
    
    -- Scale multiplier
    SCALE = 6,
}

-- Calculated values
Config.WINDOW_WIDTH = Config.BASE_WIDTH * Config.SCALE
Config.WINDOW_HEIGHT = Config.BASE_HEIGHT * Config.SCALE

return Config
