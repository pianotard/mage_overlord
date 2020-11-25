Class = require 'lib/class'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/Entity'
require 'src/Player'
require 'src/Skill'
require 'src/HitBox'
require 'src/Mob'
require 'src/StateStack'
require 'src/StateMachine'

require 'src/defs/entity_defs'
require 'src/defs/skill_defs'
require 'src/defs/map_defs'

require 'src/gui/PlayerHPBar'
require 'src/gui/PlayerMPBar'
require 'src/gui/SkillBar'
require 'src/gui/StatBar'
require 'src/gui/DamageLine'

require 'src/world/CombatMap'
require 'src/world/Fountain'

require 'src/states/player/AbstractPlayerState'
require 'src/states/player/CombatWalkState'
require 'src/states/player/AutoWalkState'
require 'src/states/player/ImmobilizeState'

require 'src/states/game/combat/CombatState'
require 'src/states/game/combat/ShowAoeState'
require 'src/states/game/combat/ShowUnitState'
require 'src/states/game/combat/WalkToTargetState'
require 'src/states/game/combat/HeldCastState'
require 'src/states/game/combat/CastSkillState'

TEXTURES = {
    ['skill'] = {
        ['energy_bolt'] = love.graphics.newImage('graphics/energy_bolt.png'),
        ['stone_smash'] = love.graphics.newImage('graphics/stone_smash.png'),
        ['lightning'] = love.graphics.newImage('graphics/lightning.png'),
        ['fireball'] = love.graphics.newImage('graphics/fireball.png'),
        ['recovery'] = love.graphics.newImage('graphics/recovery.png')
    }
}