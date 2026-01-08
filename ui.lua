local Ui = { }

local PanelImg = love.graphics.newImage('res/img/Panel.png')
local fullHeart = love.graphics.newImage('res/img/Heart-full.png')
local emptyHeart = love.graphics.newImage('res/img/Heart-empty.png')

local printScale = 0.3

function Ui:draw()
    love.graphics.draw(PanelImg, 0, 0)
    for i = 1, 3 do
        love.graphics.draw((Player.health >= i and fullHeart or emptyHeart), 5 + 16 * (i - 1), 0)
    end
    love.graphics.print("Score "..Player.score, 4, 16, 0, printScale, printScale)
end

return Ui