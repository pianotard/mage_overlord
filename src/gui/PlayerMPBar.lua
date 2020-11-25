PlayerMPBar = Class{}

function PlayerMPBar:init(player)
    self.x = PLAYER_MP_X
    self.y = PLAYER_MP_Y
    self.width = PLAYER_MP_WIDTH
    self.height = PLAYER_MP_HEIGHT
    self.color = BLUE
    self.player = player
end

function PlayerMPBar:render()        
    love.graphics.setColor(self.color)
    local mana = self.width * self.player.mp / self.player.max_mp
    love.graphics.rectangle('fill', self.x, self.y, mana, self.height)
    
    love.graphics.setColor(GRAY)
    love.graphics.rectangle('fill', self.x + mana, self.y, self.width - mana, self.height)
    love.graphics.setColor(WHITE)
end