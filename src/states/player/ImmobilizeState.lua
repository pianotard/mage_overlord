ImmobilizeState = Class{__includes = AbstractPlayerState}

function ImmobilizeState:init(player)
    AbstractPlayerState.init(self, player)
    self.player_hp_bar = PlayerHPBar(self.player)
end

function ImmobilizeState:enter(params) end
function ImmobilizeState:exit() end

function ImmobilizeState:update(dt) end

function ImmobilizeState:render()
    self.player_hp_bar:render()
    
    AbstractPlayerState.render(self)
end