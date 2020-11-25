CombatWalkState = Class{__includes = AbstractPlayerState}

function CombatWalkState:init(player)
    AbstractPlayerState.init(self, player)
    self.player_hp_bar = PlayerHPBar(self.player)
end

function CombatWalkState:enter(params) end
function CombatWalkState:exit() end

function CombatWalkState:update(dt)
    if love.keyboard.isDown('w') then
        self.player.dy = -self.player.speed
    elseif love.keyboard.isDown('s') then
        self.player.dy = self.player.speed
    else
        self.player.dy = 0
    end

    if love.keyboard.isDown('a') then
        self.player.dx = -self.player.speed
    elseif love.keyboard.isDown('d') then
        self.player.dx = self.player.speed
    else
        self.player.dx = 0
    end
    
    self.player_hp_bar.dx = self.player.dx
    self.player_hp_bar.dy = self.player.dy
    self.player_hp_bar:update(dt)
    
    AbstractPlayerState.update(self, dt)
end

function CombatWalkState:render()
    self.player_hp_bar:render()
    
    AbstractPlayerState.render(self)
end