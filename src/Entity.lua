Entity = Class{}

function Entity:init(params)
    self.x = params.x
    self.y = params.y
    self.width = params.width
    self.height = params.height
    self.dx = params.dx
    self.dy = params.dy
    self.speed = params.speed
    
    self.hp = params.hp
    self.max_hp = params.max_hp
    self.mp = params.mp
    self.max_mp = params.max_mp
    self.stats = {
        atk = params.atk, def = params.def, matk = params.matk, mdef = params.mdef
    }
    
    self.current_state = 'none'
    self.state_machine = params.state_machine
    
    self.color = params.color
end

function Entity:dead()
    return self.hp <= 0
end

function Entity:recover_mp(mp)
    self.mp = math.min(self.mp + mp, self.max_mp)
end

function Entity:recover_hp(hp)  -- This differs from Entity:heal. Entity:recover_hp is a burst recovery
    self.hp = math.min(self.hp + hp, self.max_hp)
end

function Entity:heal(heal)
    Timer.tween(HP_TWEEN, {
        [self] = {hp = math.min(self.hp + heal, self.max_hp)}
    })
end

function Entity:damage(dmg)
    Timer.tween(HP_TWEEN, {
        [self] = {hp = math.max(self.hp - dmg, 0)}
    })
end

function Entity:get_center()
    return {x = self.x + self.width / 2, y = self.y + self.height / 2}
end

function Entity:change_state(state, params)
    self.current_state = state
    self.state_machine:change(state, params)
end

function Entity:update(dt)
    self.state_machine:update(dt)
end

function Entity:render_hp_mp()
    love.graphics.setColor(GREEN)
    local hp_x = self.x + self.width / 2 - HP_WIDTH / 2
    local hp_y = self.y + self.height + HP_OFFSET_Y
    local health = HP_WIDTH * self.hp / self.max_hp
    love.graphics.rectangle('fill', hp_x, hp_y, health, HP_HEIGHT)
    
    love.graphics.setColor(MP_BLUE)
    local mp_x = self.x + self.width / 2 - MP_WIDTH / 2 + MP_OFFSET_X
    local mp_y = self.y + self.height + MP_OFFSET_Y
    local mana = MP_WIDTH * self.mp / self.max_mp
    love.graphics.rectangle('fill', mp_x, mp_y, mana, MP_HEIGHT)
    
    love.graphics.setColor(GRAY)
    love.graphics.rectangle('fill', hp_x + health, hp_y, HP_WIDTH - health, HP_HEIGHT)
    love.graphics.rectangle('fill', mp_x + mana, mp_y, MP_WIDTH - mana, MP_HEIGHT)
end

function Entity:render()
    if self.state_machine then
        self.state_machine:render()
    else
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        love.graphics.setColor(WHITE)
    end
end