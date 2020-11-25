Mob = Class{__includes = Entity}

function Mob:init(params)
    Entity.init(self, params)
end

function Mob:dead()
    return Entity.dead(self)
end

function Mob:get_center()
    return Entity.get_center(self)
end

function Mob:heal(heal)
    Entity.heal(self, heal)
end

function Mob:damage(dmg)
    Entity.damage(self, dmg)
end

function Mob:render_hp_mp()
    Entity.render_hp_mp(self)
end

function Mob:render()
    Entity.render(self)
end