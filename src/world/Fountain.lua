Fountain = Class{}

function Fountain:init(params)
    self.x = params.x
    self.y = params.y
    self.recovery = params.recovery
    self.color = params.color
    
    self.width = 70
    self.height = 70
    self.radius = 200
end

function Fountain:get_center()
    return Entity.get_center(self)
end

function Fountain:render()
    love.graphics.setColor(self.color)
    
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setLineWidth(2)
    love.graphics.circle('line', self.x + self.width / 2, self.y + self.height / 2, self.radius)
    
    love.graphics.setColor(WHITE)
end