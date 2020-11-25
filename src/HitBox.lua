HitBox = Class{}

function HitBox:init(width, height)
    self.x = 0
    self.y = 0
    self.width = width
    self.height = height
    self.color = BLUE
end

function HitBox:covers(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
                self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function HitBox:reset_color()
    self.color = BLUE
end

function HitBox:get_center()
    return {x = self.x + self.width / 2, y = self.y + self.height / 2}
end

function HitBox:set_center(x, y)
    self.x = x - self.width / 2
    self.y = y - self.height / 2
end

function HitBox:update(dt) end

function HitBox:render()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(WHITE)
end