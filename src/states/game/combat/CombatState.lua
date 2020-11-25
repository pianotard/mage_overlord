CombatState = Class{__includes = AbstractState}

function CombatState:init(params)
    self.player = params.player
    self.map = CombatMap({
        name = params.map, player = params.player
    })
end

function CombatState:enter()
    self.skill_bindings = {q = 1, e = 2, r = 3, f = 4, space = 5}
    self.skills = {}
    
    self.player:change_state('combat_walk')
    
    local player_skills = self.player.set_skills
    assert(#player_skills <= 5, 'invalid number of skills provided')
    for i, skill_name in pairs(player_skills) do
        local s = SKILL_DEFS[skill_name]
        table.insert(self.skills, Skill({
            name = s.name, target = s.target, texture = s.texture,
            max_range = s.max_range, aoe_width = s.aoe_width, aoe_height = s.aoe_height, 
            cast_time = s.cast_time, cooldown = s.cooldown,
            power = s.power, damage_lines = s.dmg_lines, class = s.class, heal = s.heal, mp_cost = s.mp_cost
        }))
    end
    
    self.skill_bar = SkillBar(self.skills)
    self.stat_bar = StatBar(self.player)
end

function CombatState:exit() end

function CombatState:update(dt)    
    text = 'STACK: combat (ready) state'
    
    self.map:update(dt)
    self.player:update(dt)    
    
    for key, ind in pairs(self.skill_bindings) do
        if love.keyboard.wasPressed(key) and 
            not self.skills[ind].on_cooldown and 
            self.player.mp >= self.skills[ind].mp_cost then
            
            local target = self.skills[ind].target
            if target == 'aoe' then
                STATE_STACK:push(ShowAoeState({
                    player = self.player, map = self.map, skills = self.skills, mobs = self.mobs, 
                    skill_ind = ind, skill_bindings = self.skill_bindings
                }))
            elseif target == 'unit' then
                STATE_STACK:push(ShowUnitState({
                    player = self.player, map = self.map, skills = self.skills, mobs = self.mobs, 
                    skill_ind = ind, skill_bindings = self.skill_bindings
                }))
            elseif target == 'self' then
                STATE_STACK:push(HeldCastState({
                    player = self.player, map = self.map, skills = self.skills, mobs = self.mobs, 
                    skill_ind = ind, skill_bindings = self.skill_bindings, bound_key = key
                }))
            end
            break
        end
    end
end

function CombatState:render()
    love.graphics.printf(text, 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
    
    self.map:render()
        
    self.skill_bar:render()
    self.stat_bar:render()
end