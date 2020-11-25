Skill = Class{}

function Skill:init(params)
    self.name = params.name
    self.target = params.target
    self.max_range = params.max_range or 0
    self.hit_box = HitBox(params.aoe_width, params.aoe_height)
    self.cast_time = params.cast_time
    
    self.cooldown = params.cooldown
    self.on_cooldown = false
    self.cd_timer = 0
    
    self.class = params.class
    self.power = params.power or 0
    self.num_lines = params.damage_lines
    assert(self.num_lines > 0, 'Not enough damage lines provided')
    self.mp_cost = params.mp_cost
    
    self.texture = params.texture or 0
end

function Skill:heal_line(stats)
    return DamageLine({
        damage = self.power * (stats.matk + stats.mdef) / 2,
        color = GREEN
    })
end

function Skill:damage_lines(attacker_stats, defender_stats)
    ret = {}
    if self.class == 'physical' then
        local atk = attacker_stats.atk
        local def = defender_stats.def
        repeat
            table.insert(ret, DamageLine({
                damage = self.power * 2 * atk * atk / (atk + def),
                color = DAMAGE_ORANGE,
                sign = '-'
            }))
        until #ret == self.num_lines
        return ret
    elseif self.class == 'magic' then       
        local matk = attacker_stats.matk
        local mdef = defender_stats.mdef
        repeat
            table.insert(ret, DamageLine({
                damage = self.power * 2 * matk * matk / (matk + mdef),
                color = DAMAGE_ORANGE,
                sign = '-'                    
            }))
        until #ret == self.num_lines
        return ret
    end
end

function Skill:start_cooldown()
    self.on_cooldown = true
    Timer.tween(self.cooldown, {
        [self] = {cd_timer = 1}
    }):finish(function()
        self.on_cooldown = false
        self.cd_timer = 0
    end)
end