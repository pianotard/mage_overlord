ShowAoeState = Class{__includes = AbstractState}

function ShowAoeState:init(params)
    self.player = params.player
    self.skills = params.skills
    self.map = params.map
    self.skill_index = params.skill_ind
    self.skill_bindings = params.skill_bindings

    self.skill = self.skills[self.skill_index]
    
end

function ShowAoeState:enter()
    self.skill.hit_box:set_center(love.mouse.x, love.mouse.y)
    self.skill.hit_box:reset_color()
end

function ShowAoeState:exit() 
    self.skill.hit_box:reset_color()
end

function ShowAoeState:update(dt)
    text = 'STACK: show aoe state.. '..self.skill.name

    self.map:update(dt)
    self.player:update(dt)
    self.skill.hit_box:set_center(love.mouse.x, love.mouse.y)
    
    for key, ind in pairs(self.skill_bindings) do
        if love.keyboard.wasPressed(key) and 
            not self.skills[ind].on_cooldown and 
            self.player.mp >= self.skills[ind].mp_cost then
            
            local target = self.skills[ind].target
            STATE_STACK:pop()  -- Pops current ShowAoeState
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
    
    local t_c = self.skill.hit_box:get_center()
    local p_c = self.player:get_center()
    local in_range = false
    if (t_c['x'] - p_c['x']) ^ 2 + (t_c['y'] - p_c['y']) ^ 2 > self.skill.max_range ^ 2 then
        self.skill.hit_box.color = RED
        in_range = false
    else
        self.skill.hit_box:reset_color()
        in_range = true
    end
    
    if love.keyboard.wasPressed('lctrl') then
        STATE_STACK:pop()  -- Pops ShowAoeState
    end  -- ends in CombatState
    
    if love.mouse.wasPressed(1) and in_range and self.player.mp >= self.skill.mp_cost then
        STATE_STACK:push(CastSkillState({
            player = self.player, skills = self.skills, map = self.map, skill = self.skill, skill_ind = self.skill_index,
            skill_bindings = self.skill_bindings
        }))
    end
end

function ShowAoeState:render()    
    self.skill.hit_box:render()
end