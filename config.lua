-- Global configuration variables
local Config = {
    -- Base resolution
    BASE_WIDTH = 128,
    BASE_HEIGHT = 128,
    
    -- Scale multiplier
    SCALE = 3,
}

-- Load scale from settings if available
local settingsFile = io.open('Scale.txt', 'r')
if settingsFile then
    local scale = tonumber(settingsFile:read('*n'))
    if scale then
        Config.SCALE = scale
    end
    settingsFile:close()
end

-- Calculated values
Config.WINDOW_WIDTH = Config.BASE_WIDTH * Config.SCALE
Config.WINDOW_HEIGHT = Config.BASE_HEIGHT * Config.SCALE

return Config
