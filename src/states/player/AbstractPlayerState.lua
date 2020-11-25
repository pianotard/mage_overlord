AbstractPlayerState = Class{__includes = AbstractState}

function AbstractPlayerState:init(player)
    self.player = player
end

function AbstractPlayerState:enter(params) end
function AbstractPlayerState:exit() end

function AbstractPlayerState:update(dt)
    if self.player.dx < 0 then
        self.player.x = math.max(self.player.x + self.player.dx * dt, 1)
    elseif self.player.dx > 0 then
        self.player.x = math.min(self.player.x + self.player.dx * dt, WINDOW_WIDTH - self.player.width - 1)
    end
    if self.player.dy < 0 then
        self.player.y = math.max(self.player.y + self.player.dy * dt, 1)
    elseif self.player.dy > 0 then
        self.player.y = math.min(self.player.y + self.player.dy * dt, WINDOW_HEIGHT - self.player.height - 1)
    end
end

function AbstractPlayerState:render() 
    love.graphics.setColor(self.player.color)
    love.graphics.rectangle('fill', self.player.x, self.player.y, self.player.width, self.player.height)
    love.graphics.setColor(WHITE)
end