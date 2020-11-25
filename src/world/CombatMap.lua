CombatMap = Class{}

function CombatMap:init(params)
    self.name = params.name
    self.player = params.player
    self.player_mp_bar = PlayerMPBar(self.player)

    self.mobs = {}
    self.damage_lines = {}
    self.heal_lines = {}
    self.mob_cap = MAP_DEFS[self.name].mob_cap
    self.spawn_freq = MAP_DEFS[self.name].spawn_freq
    mob_types = MAP_DEFS[self.name].possible_mobs
    for i = 1, self.mob_cap do
        self:schedule_spawn_mob()
    end
    self.mob_count = self.mob_cap
    
    self.mp_fountains = {}
    for i = 1, #MAP_DEFS[self.name].mp_fountains do
        local fountain = MAP_DEFS[self.name].mp_fountains[i]
        table.insert(self.mp_fountains, Fountain({
            x = fountain.x, y = fountain.y, recovery = fountain.recovery, color = fountain.color
        }))
    end
    
    self.hp_fountains = {}
    for i = 1, #MAP_DEFS[self.name].hp_fountains do
        local fountain = MAP_DEFS[self.name].hp_fountains[i]
        table.insert(self.hp_fountains, Fountain({
            x = fountain.x, y = fountain.y, recovery = fountain.recovery, color = fountain.color
        }))
    end
end

function CombatMap:attach_heal_line(entity, line)
    local id = -1
    repeat
        id = math.random(M)
    until self.heal_lines[id] == nil
    line.x = entity.x + entity.width / 2 - DAMAGE_LINE_WIDTH / 2 + math.random(-5, 5)
    line.y = entity.y
    self.heal_lines[id] = line
    Timer.tween(1, {
        [line] = {y = entity.y - DAMAGE_LINE_HEIGHT}
    }):finish(function()
        self.heal_lines[id] = nil
    end)    
end

function CombatMap:attach_damage_lines(entity, dmg_lines)
    local num_lines = #dmg_lines
    
    local function attach(entity, line)
        local id = -1
        repeat
            id = math.random(M)
        until self.damage_lines[id] == nil
        line.x = entity.x + entity.width / 2 - DAMAGE_LINE_WIDTH / 2 + math.random(-5, 5)
        line.y = entity.y
        self.damage_lines[id] = line
        Timer.tween(0.7, {
            [line] = {y = entity.y - num_lines * DAMAGE_LINE_HEIGHT / 2}
        }):finish(function()
            self.damage_lines[id] = nil
        end)
    end
    
    attach(entity, table.remove(dmg_lines))

    if num_lines > 1 then
        Timer.every(DAMAGE_LINE_INTERVAL, function()
            attach(entity, table.remove(dmg_lines))
        end):limit(num_lines - 1)
    end
end

function CombatMap:schedule_spawn_mob()
    Timer.after(math.random(self.spawn_freq), function()
        self:spawn_mob()
    end)
end

function CombatMap:spawn_mob()
    local mob = ENTITY_DEFS[mob_types[math.random(#mob_types)]]
    local x = math.random(WINDOW_WIDTH - mob.width)
    local y = math.random(WINDOW_HEIGHT - mob.height)
    table.insert(self.mobs, Mob({
        x = x, y = y, width = mob.width, height = mob.height, dx = 0, dy = 0, 
        hp = mob.hp, max_hp = mob.max_hp,
        mp = mob.mp, max_mp = mob.max_mp,
        atk = mob.atk, def = mob.def, matk = mob.matk, mdef = mob.mdef,
        state_machine = nil, color = mob.color
    }))
end

function CombatMap:update(dt)
    for i, mob in pairs(self.mobs) do
        if mob:dead() then
            self.mobs[i] = nil
            self.mob_count = self.mob_count - 1
        end
    end
    
    while self.mob_count < self.mob_cap do
        self:schedule_spawn_mob()
        self.mob_count = self.mob_count + 1
    end
    
    for i, fountain in pairs(self.mp_fountains) do
        local p_c = self.player:get_center()
        local f_c = fountain:get_center()
        if (f_c['x'] - p_c['x']) ^ 2 + (f_c['y'] - p_c['y']) ^ 2 <= fountain.radius ^ 2 then
            self.player:recover_mp(fountain.recovery * dt)
        end
    end

    for i, fountain in pairs(self.hp_fountains) do
        local p_c = self.player:get_center()
        local f_c = fountain:get_center()
        if (f_c['x'] - p_c['x']) ^ 2 + (f_c['y'] - p_c['y']) ^ 2 <= fountain.radius ^ 2 then
            self.player:recover_hp(fountain.recovery * dt)
        end
    end
end

function CombatMap:render()
    for i, mob in pairs(self.mobs) do
        mob:render()
        mob:render_hp_mp()
    end
    
    self.player:render()

    for i, fountain in pairs(self.mp_fountains) do
        fountain:render()
    end
        
    for i, fountain in pairs(self.hp_fountains) do
        fountain:render()
    end    
    
    for i, line in pairs(self.damage_lines) do
        line:render()
    end
    
    for i, line in pairs(self.heal_lines) do
        line:render()
    end
    
    self.player_mp_bar:render()
    self.player:render_exp()
end