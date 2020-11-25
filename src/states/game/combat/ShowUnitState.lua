ShowUnitState = Class{__includes = AbstractState}

function ShowUnitState:init(params)
    self.player = params.player
    self.skills = params.skills
    self.map = params.map
    
    self.skill_index = params.skill_ind
    self.skill_bindings = params.skill_bindings

    self.skill = self.skills[self.skill_index]
end

function ShowUnitState:enter()
    self.mob_hit = 0
end

function ShowUnitState:exit() end

function ShowUnitState:update(dt)
    text = 'STACK: show unit state.. '..self.skill.name

    self.map:update(dt)
    self.player:update(dt)
    self.skill.hit_box:set_center(love.mouse.x, love.mouse.y)
    
    for key, ind in pairs(self.skill_bindings) do
        if love.keyboard.wasPressed(key) and 
            not self.skills[ind].on_cooldown and 
            self.player.mp >= self.skills[ind].mp_cost then
            
            local target = self.skills[ind].target
            STATE_STACK:pop()  -- Pops current ShowUnitState
            if target == 'aoe' then
                STATE_STACK:push(ShowAoeState({
                    player = self.player, skills = self.skills, map = self.map, 
                    skill_ind = ind, skill_bindings = self.skill_bindings
                }))
            elseif target == 'unit' then
                STATE_STACK:push(ShowUnitState({
                    player = self.player, skills = self.skills, map = self.map, 
                    skill_ind = ind, skill_bindings = self.skill_bindings
                }))
            elseif target == 'self' then
                STATE_STACK:push(HeldCastState({
                    player = self.player, skills = self.skills, map = self.map, 
                    skill_ind = ind, skill_bindings = self.skill_bindings, bound_key = key
                }))
            end
            break
        end
    end
    
    if love.keyboard.wasPressed('lctrl') then
        STATE_STACK:pop()  -- Pops ShowUnitState
    end  -- ends in CombatState
    
    self.mob_hit = 0
    local mouse = {x = love.mouse.x, y = love.mouse.y}
    for i, mob in pairs(self.map.mobs) do
        if self.skill.hit_box:covers(mob) then
            self.mob_hit = i
            break
        end
    end
    
    if love.mouse.wasPressed(1) and self.mob_hit > 0 and self.player.mp >= self.skill.mp_cost then        
        local t_c = self.map.mobs[self.mob_hit]:get_center()
        local p_c = self.player:get_center()
        if (t_c['x'] - p_c['x']) ^ 2 + (t_c['y'] - p_c['y']) ^ 2 > self.skill.max_range ^ 2 then
            STATE_STACK:push(WalkToTargetState({
                player = self.player, skills = self.skills, map = self.map, skill = self.skill, skill_ind = self.skill_index,
                target = self.map.mobs[self.mob_hit], skill_bindings = self.skill_bindings,
            }))
        else
            STATE_STACK:push(CastSkillState({
                player = self.player, skills = self.skills, map = self.map, skill = self.skill, skill_ind = self.skill_index,
                skill_bindings = self.skill_bindings
            }))        
        end
    end
end

function ShowUnitState:render()   
    if self.mob_hit > 0 then
        local mob = self.map.mobs[self.mob_hit]
        love.graphics.setColor(GREEN)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle('line', mob.x - 2, mob.y - 2, mob.width + 4, mob.height + 4)
        love.graphics.setColor(WHITE)
    end
end