WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

M = 1000

HP_OFFSET_Y = 4
HP_WIDTH = 100
HP_HEIGHT = 8
HP_TWEEN = 0.5

MP_OFFSET_X = 6
MP_OFFSET_Y = 14
MP_WIDTH = 100
MP_HEIGHT = 8

EXP_WIDTH = WINDOW_WIDTH
EXP_HEIGHT = 10
EXP_Y = WINDOW_HEIGHT - EXP_HEIGHT - 8

PLAYER_HP_WIDTH = 22
PLAYER_HP_HEIGHT = 94

PLAYER_MP_WIDTH = WINDOW_WIDTH
PLAYER_MP_HEIGHT = 40
PLAYER_MP_X = 0
PLAYER_MP_Y = EXP_Y - PLAYER_MP_HEIGHT - 8

SKILLBAR_Y = PLAYER_MP_Y - 2
SKILL_RADIUS = 22
SKILL_PADDING = 20
SKILLBAR_WIDTH = SKILL_RADIUS * 2 * 5 + SKILL_PADDING * 6

STATBAR_X = SKILLBAR_WIDTH + 40
STATBAR_Y = PLAYER_MP_Y

DAMAGE_LINE_INTERVAL = 0.3
DAMAGE_LINE_WIDTH = 100
DAMAGE_LINE_HEIGHT = 20

DEG_TO_RAD = math.pi / 180

BLACK = {0, 0, 0}
BLUE = {55 / 255, 183 / 255, 247 / 255, 0.5}
CHALK = {245 / 255, 247 / 255, 181 / 255}
DAMAGE_ORANGE = {247 / 255, 190 / 255, 32 / 255}
GRAY = {191 / 255, 191 / 255, 191 / 255}
GREEN = {17 / 255, 242 / 255, 92 / 255, 0.5}
MP_BLUE = {35 / 255, 48 / 255, 228 / 255}
RED = {1, 0, 0}
WHITE = {1, 1, 1}
YELLOW = {245 / 255, 252 / 255, 39 / 255}