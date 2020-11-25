PlayerHPBar = Class{}

function PlayerHPBar:init(player)
    self.player = player
    
    self.x = self.player.x - 30
    self.y = self.player.y - 20
    self.width = PLAYER_HP_WIDTH
    self.height = PLAYER_HP_HEIGHT
    self.color = GREEN
    
    local mask = love.graphics.newImage('graphics/hp_bar_mask.png')
 
    local mask_shader = love.graphics.newShader[[
       vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
          if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
             // a discarded pixel wont be applied as the stencil.
             discard;
          }
          return vec4(1.0);
       }
    ]]

    self.stencil = function()
       love.graphics.setShader(mask_shader)
       love.graphics.draw(mask, self.x, self.y)
       love.graphics.setShader()
    end
end

function PlayerHPBar:update(dt)
    self.x = self.x + self.player.dx * dt
    self.y = self.y + self.player.dy * dt
end

function PlayerHPBar:render()    
    love.graphics.stencil(self.stencil, 'replace', 1)
    love.graphics.setStencilTest('greater', 0)
    
    love.graphics.setColor(self.color)
    local health = self.height * self.player.hp / self.player.max_hp
    love.graphics.rectangle('fill', self.x, self.y + self.height - health, self.width, health)
    
    love.graphics.setColor(GRAY)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height - health)
    love.graphics.setColor(WHITE)
    
    love.graphics.setStencilTest()
end