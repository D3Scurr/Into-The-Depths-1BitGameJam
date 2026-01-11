local state = { }

function state:draw()
    love.graphics.print("R - restart", Config.WINDOW_HEIGHT/2 - 58, Config.WINDOW_WIDTH/2 + 75)
    love.graphics.print("Game Over", Config.WINDOW_HEIGHT/2 - 45, Config.WINDOW_WIDTH/2 - 20)
    love.graphics.print("HighScore: "..HighScore, Config.WINDOW_HEIGHT/2 - 60, Config.WINDOW_WIDTH/2 + 20)
end

return state