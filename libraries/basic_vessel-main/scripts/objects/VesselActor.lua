local VesselActor, super = Class(ActorSprite)

function VesselActor:init(actor, data)
    super:init(self, actor)

    self.parts = {vessel_head(self, data), vessel_torso(self, data), vessel_legs(self, data)}--, vessel_torso(self, data), vessel_legs(self, data)}

    for _,v in pairs(self.parts) do
        v:setOrigin(0.5, 1)
        self:addChild(v)
        v:update_part()
    end
    self.last_sprite = self.sprite_options[1]
end

function VesselActor:draw()

    --if self.sprite_options[1] == "walk/down_3" then self.sprite_options[1] = "walk/down_1" end

    if self.last_sprite ~= self.sprite_options[1] then
        for _, v in pairs(self.parts) do
            v:update_part()
        end
    end

    self.last_sprite = self.sprite_options[1]

    super:draw(self)
end

return VesselActor