WalkToTargetState = Class{__includes = AbstractState}

function WalkToTargetState:init(params)
    self.player = params.player
    self.skills = params.skills
    self.skill = params.skill
    self.map = params.map
    self.target = params.target
    
    self.skill_index = params.skill_ind
    self.skill_bindings = params.skill_bindings
end

function WalkToTargetState:enter() 
    self.player:change_state('auto_walk', {target = self.target})
end

function WalkToTargetState:exit() 
    local t_c = self.target:get_center()
    self.skill.hit_box:set_center(t_c['x'], t_c['y'])
    self.player:change_state('combat_walk')
end

function WalkToTargetState:update(dt)
    text = 'STACK: walk to target state.. '..self.skill.name
    
    self.map:update(dt)
    self.player:update(dt)
    
    if love.keyboard.wasPressed('lctrl') then
        STATE_STACK:pop()  -- Pops WalkToTargetState
        STATE_STACK:pop()  -- Pops ShowUnitState
    end  -- ends in CombatState
    
    for key, ind in pairs(self.skill_bindings) do
        if love.keyboard.wasPressed(key) and ind ~= self.index then
            STATE_STACK:pop()  -- Pops current WalkToTargetState
            STATE_STACK:pop()  -- Pops previous ShowUnitState
            local target = self.skills[ind].target
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
    
    local t_c = self.target:get_center()
    local p_c = self.player:get_center()
    if (t_c['x'] - p_c['x']) ^ 2 + (t_c['y'] - p_c['y']) ^ 2 <= self.skill.max_range ^ 2 then
        STATE_STACK:pop()  -- Pops current WalkToTargetState
        STATE_STACK:push(CastSkillState({
            player = self.player, skills = self.skills, map = self.map, skill = self.skill, skill_ind = self.skill_index,
            skill_bindings = self.skill_bindings
        }))
    end
end

function WalkToTargetState:render() end