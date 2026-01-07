local Ui = { }

local leftPanelImg = love.graphics.newImage('res/img/Left-panel.png')
local fullHeart = love.graphics.newImage('res/img/Heart-full.png')
local emptyHeart = love.graphics.newImage('res/img/Heart-empty.png')

local printScale = 1.3

function Ui:draw()
    love.graphics.draw(leftPanelImg, 0, 0)
    for i = 1, 3 do
        love.graphics.draw((Player.health >= i and fullHeart or emptyHeart), 4 + 16 * (i - 1), 0)
    end
    love.graphics.print("Score "..Player.score, Config.BASE_WIDTH/2, 0, 0, printScale, printScale)
end

return Ui