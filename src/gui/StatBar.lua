StatBar = Class{}

function StatBar:init(player)
    self.player = player
    self.x = STATBAR_X
    self.y = STATBAR_Y
    self.stat_width = 100
end

function StatBar:render()     
    love.graphics.setColor(BLACK)
    love.graphics.printf('Atk: '..self.player.stats.atk, self.x, self.y + 3, self.stat_width, 'left')
    love.graphics.printf('Def: '..self.player.stats.def, self.x + self.stat_width, self.y + 3, self.stat_width, 'left')
    love.graphics.printf('MAtk: '..self.player.stats.matk, self.x, self.y + 23, self.stat_width, 'left')
    love.graphics.printf('MDef: '..self.player.stats.mdef, self.x + self.stat_width, self.y + 23, self.stat_width, 'left')
    love.graphics.setColor(WHITE)
end