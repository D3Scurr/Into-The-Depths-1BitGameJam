local menu = { }

local Background = love.graphics.newImage('res/img/menu.png')

function menu:draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    love.graphics.draw(Background, 0, 0)
    love.graphics.scale(1/Config.SCALE, 1/Config.SCALE)
    love.graphics.print("Made by D3Scurr for 1-BIT JAM 8!", 4, 4)
end

return menu