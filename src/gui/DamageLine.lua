DamageLine = Class{}

function DamageLine:init(params)
    self.damage = math.floor(params.damage)
    self.color = params.color
    self.sign = params.sign or ''
    self.x = 0
    self.y = 0
    self.width = DAMAGE_LINE_WIDTH
end

function DamageLine:render()
    love.graphics.setColor(self.color)
    love.graphics.printf(self.sign..self.damage, self.x, self.y, self.width, 'center')
    love.graphics.setColor(WHITE)
end