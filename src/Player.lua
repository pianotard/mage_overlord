Player = Class{__includes = Entity}

function Player:init(params)
    Entity.init(self, params)
    self.set_skills = params.set_skills
    self.exp = params.exp
    self.max_exp = params.max_exp
end

function Player:dead()
    return Entity.dead(self)
end

function Player:heal(heal)
    Entity.heal(self, heal)
end

function Player:damage(dmg)
    Entity.damage(self, dmg)
end

function Player:get_center()
    return Entity.get_center(self)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render_hp_mp()
    Entity.render_hp_mp(self)
end

function Player:render_exp()
    local experience = EXP_WIDTH * self.exp / self.max_exp
    
    love.graphics.setColor(YELLOW)
    love.graphics.rectangle('fill', 0, EXP_Y, experience, EXP_HEIGHT)
    
    love.graphics.setColor(GRAY)
    love.graphics.rectangle('fill', experience, EXP_Y, EXP_WIDTH - experience, EXP_HEIGHT)
    
    love.graphics.setColor(WHITE)
end

function Player:render()
    Entity.render(self)
end