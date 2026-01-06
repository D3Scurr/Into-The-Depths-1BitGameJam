Timer = {
    ObstacleWait = 0,
    ObstacleOnScreen = 0
}

function Timer:update(dt)
    Timer.ObstacleWait = Timer.ObstacleWait + dt
    if Timer.ObstacleWait >= 2 then
        Timer.ObstacleOnScreen = Timer.ObstacleOnScreen + dt
    end
end

return Timer