SkillBar = Class{}

function SkillBar:init(skills)
    self.skills = skills
    self.end_angle = 270 * DEG_TO_RAD
    self.skill_radius = SKILL_RADIUS
    self.padding = SKILL_PADDING
end

function SkillBar:render()        
    local x = self.padding
    love.graphics.setColor(GRAY)
    for i, skill in pairs(self.skills) do
        texture = TEXTURES['skill'][skill.texture]
        if texture then
            love.graphics.draw(texture, x, SKILLBAR_Y)
        else
            love.graphics.circle('fill', x + self.skill_radius, SKILLBAR_Y + self.skill_radius, self.skill_radius)
        end
        if skill.on_cooldown then
            local angle = (skill.cd_timer * 360 - 90) * DEG_TO_RAD
            love.graphics.arc('fill', x + self.skill_radius, SKILLBAR_Y + self.skill_radius, 
                self.skill_radius, angle, self.end_angle)
        end
        x = x + self.skill_radius * 2 + self.padding
    end
    love.graphics.setColor(WHITE)
end