local state = { }

function state:draw()
    love.graphics.print("Game Over", Config.WINDOW_HEIGHT/2, Config.WINDOW_WIDTH/2)
end

return state