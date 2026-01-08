local Ui = { }

local PanelImg = love.graphics.newImage('res/img/Panel.png')
local fullHeart = love.graphics.newImage('res/img/Heart-full.png')
local emptyHeart = love.graphics.newImage('res/img/Heart-empty.png')
local fullBunk = love.graphics.newImage('res/img/Bunk-point-full.png')
local emptyBunk = love.graphics.newImage('res/img/Bunk-point-empty.png')

local printScale = 0.5

function Ui:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', Config.BASE_WIDTH / 2, 0, Config.BASE_WIDTH / 2, 22)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 84, 3, Player.bunkMeter * 40 / 100, 8)
    
    love.graphics.draw(PanelImg, 0, 0)
    for i = 1, 3 do
        love.graphics.draw((Player.health >= i and fullHeart or emptyHeart), 5 + 16 * (i - 1), -1.1)
    end
    for i = 1, 3 do
        love.graphics.draw((Player.bunkPoints >= i and fullBunk or emptyBunk), Config.BASE_WIDTH - (3.5 * 8) + 8 * (i - 1), 12)
    end
    love.graphics.print(Player.score, 4 + 22, 14, 0, printScale, printScale)
end

return Ui