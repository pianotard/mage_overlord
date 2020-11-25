HeldCastState = Class{__includes = AbstractPlayerState}

function HeldCastState:init(params)
    self.player = params.player
    self.skills = params.skills
    self.skill = self.skills[params.skill_ind]
    self.skill_bindings = params.skill_bindings
    self.key = params.bound_key
    self.map = params.map
end

function HeldCastState:enter() 
    self.skill.hit_box.show = true
    self.skill.hit_box.color = RED
    local p_c = self.player:get_center()
    self.skill.hit_box:set_center(p_c.x, p_c.y)
    
    self.timer = Timer.tween(self.skill.cast_time, {
        [self.player] = {mp = self.player.mp - self.skill.mp_cost}
    }):finish(function()
        self.skill.hit_box.color = GREEN
        for i, mob in pairs(self.map.mobs) do
            if self.skill.hit_box:covers(mob) then
                local damage_lines = self.skill:damage_lines(self.player.stats, mob.stats)
                total_damage = 0
                for i, dmg in pairs(damage_lines) do
                    total_damage = damage + dmg
                end
                mob:damage(total_damage)
                self.map:attach_damage_lines(mob, damage_lines)  -- damage_lines mutated!
            end
        end
        local heal_line = self.skill:heal_line(self.player.stats)
        self.player:heal(heal_line.damage)
        self.map:attach_heal_line(self.player, heal_line)
            
        self.skill:start_cooldown()
        STATE_STACK:pop()  -- Pops HeldCastState
    end)  -- ends in CombatState
end

function HeldCastState:exit() 
    self.skill.hit_box.show = false
    self.skill.hit_box:reset_color()
    self.timer:remove()
end

function HeldCastState:update(dt)
    text = 'STACK: held cast state.. '..self.skill.name

    self.map:update(dt)
    self.player:update(dt)
    
    local p_c = self.player:get_center()
    self.skill.hit_box:set_center(p_c.x, p_c.y)
    
    if love.keyboard.wasPressed('lctrl') or not love.keyboard.isDown(self.key) then
        STATE_STACK:pop()  -- Pops HeldCastState
    end  -- ends in CombatState
end

function HeldCastState:render() end