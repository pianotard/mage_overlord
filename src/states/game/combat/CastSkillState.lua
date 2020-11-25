CastSkillState = Class{__includes = AbstractPlayerState}

function CastSkillState:init(params)
    self.player = params.player
    self.skills = params.skills
    self.skill = params.skill
    self.skill_index = params.skill_ind
    self.skill_bindings = params.skill_bindings
    self.map = params.map
end

function CastSkillState:enter() 
    self.skill.hit_box.show = true
    self.skill.hit_box.color = GREEN
    
    self.player:change_state('immobilize')
    
    self.timer = Timer.tween(self.skill.cast_time, {
        [self.player] = {mp = self.player.mp - self.skill.mp_cost}
    }):finish(function()
        if self.skill.class ~= 'heal' then
            for i, mob in pairs(self.map.mobs) do
                if self.skill.hit_box:covers(mob) then
                    local damage_lines = self.skill:damage_lines(self.player.stats, mob.stats)
                    total_damage = 0
                    for i, dmg in pairs(damage_lines) do
                        total_damage = total_damage + dmg.damage
                    end
                    mob:damage(total_damage)
                    self.map:attach_damage_lines(mob, damage_lines)  -- damage_lines mutated!
                end
            end
        else
            local heal_line = self.skill:heal_line(self.player.stats)
            self.player:heal(heal_line.damage)
            self.map:attach_heal_line(self.player, heal_line)
        end
            
        self.skill:start_cooldown()
        STATE_STACK:pop()  -- Pops CastskillState
        STATE_STACK:pop()  -- Pops ShowAoeState
    end)  -- ends in CombatState
end

function CastSkillState:exit() 
    self.skill.hit_box.show = false
    self.skill.hit_box:reset_color()
    self.timer:remove()
    self.player:change_state('combat_walk')
end

function CastSkillState:update(dt)
    text = 'STACK: cast skill state.. '..self.skill.name
    
    self.map:update(dt)
    self.player:update(dt)
    
    if love.keyboard.wasPressed('lctrl') then
        STATE_STACK:pop()  -- Pops CastSkillState
        STATE_STACK:pop()  -- Pops ShowState
    end  -- ends in CombatState
end

function CastSkillState:render() end