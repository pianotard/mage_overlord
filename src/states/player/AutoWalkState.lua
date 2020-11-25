AutoWalkState = Class{__includes = AbstractPlayerState}

function AutoWalkState:init(player)
    AbstractPlayerState.init(self, player)
    self.player_hp_bar = PlayerHPBar(self.player)
end

function AutoWalkState:enter(params) 
    self.target = params.target
end

function AutoWalkState:exit() end

function AutoWalkState:update(dt)
    local t_c = self.target:get_center()
    local p_c = self.player:get_center()
    local vector = {x = t_c.x - p_c.x, y = t_c.y - p_c.y}
    local dist = math.sqrt(vector.x ^ 2 + vector.y ^ 2)
    self.player.dx = vector.x * self.player.speed / dist
    self.player.dy = vector.y * self.player.speed / dist
    
    self.player_hp_bar.dx = self.player.dx
    self.player_hp_bar.dy = self.player.dy
    self.player_hp_bar:update(dt)
    
    AbstractPlayerState.update(self, dt)
end

function AutoWalkState:render()
    self.player_hp_bar:render()
    
    AbstractPlayerState.render(self)
end