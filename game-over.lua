local state = { }

function state:draw()
    love.graphics.print("Game Over", Config.WINDOW_HEIGHT/2, Config.WINDOW_WIDTH/2)
    love.graphics.print("HighScore: "..HighScore, Config.WINDOW_HEIGHT/2, Config.WINDOW_WIDTH/2 + 20)
end

return state