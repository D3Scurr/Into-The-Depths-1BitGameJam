local pause = { }

local pauseImage = love.graphics.newImage('res/img/pause.png')

function pause:enter()
    Paused = true
    
    sounds.theme:pause()
    sounds.pause:play()
end

function pause:draw()
    love.graphics.scale(Config.SCALE, Config.SCALE)
    love.graphics.draw(pauseImage, 0, 0)
end

function pause:leave()
    Paused = false

    sounds.unPause:play()
    sounds.theme:play()
end

return pause