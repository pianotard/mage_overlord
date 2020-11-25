SKILL_DEFS = {
    ['energy_bolt'] = {
        name = 'Energy Bolt', target = 'unit', texture = 'energy_bolt',
        max_range = 300, aoe_width = 100, aoe_height = 100, cast_time = 0.8, cooldown = 2,
        power = 1.2, dmg_lines = 1, class = 'magic', mp_cost = 5
    },
    ['stone_smash'] = {
        name = 'Stone Smash', target = 'unit', texture = 'stone_smash',
        max_range = 50, aoe_width = 50, aoe_height = 50, cast_time = 0.2, cooldown = 1,
        power = 1, dmg_lines = 2, class = 'physical', mp_cost = 2
    },
    ['stone_throw'] = {
        name = 'Stone Throw', target = 'unit',
        max_range = 300, aoe_width = 60, aoe_height = 60, cast_time = 0.4, cooldown = 1.2,
        power = 0.9, dmg_lines = 1, class = 'physical', mp_cost = 3
    },
    ['lightning'] = {
        name = 'Lightning', target = 'aoe', texture = 'lightning',
        max_range = 600, aoe_width = 150, aoe_height = 150, cast_time = 1.5, cooldown = 4,
        power = 1.3, dmg_lines = 3, class = 'magic', mp_cost = 10
    },
    ['fireball'] = {
        name = 'Fireball', target = 'aoe', texture = 'fireball',
        max_range = 300, aoe_width = 150, aoe_height = 150, cast_time = 1.5, cooldown = 4,
        power = 1.8, dmg_lines = 1, class = 'magic', mp_cost = 10
    },
    ['recovery'] = {
        name = 'Recovery', target = 'self', texture = 'recovery',
        aoe_width = 50, aoe_height = 50, cast_time = 3, cooldown = 5,
        power = 1, dmg_lines = 1, class = 'heal', mp_cost = 20
    }
}