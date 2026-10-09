local vessel_legs, super = Class(Object)

function vessel_legs:init(vessel, data)
    super:init(self)
    self.vessel = vessel

    self.legs_sprite = Sprite("vessel/legs/"..data.legs.."/"..self.vessel.sprite_options[2])
    self:addChild(self.legs_sprite)
     
    self.legs_path = "vessel/legs/"..data.legs.."/"

    print(data.legs)

    self.offsets = {
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0}
    }
end

function vessel_legs:part_set(legs, name, frame, walk)

        if legs[name] == 1 then
            legs:setSprite(self.legs_path .. name)
        else
            local number = (frame - 1) % legs[name] + 1 
            if number == 3 and walk == "walk" then number = 1 end
            legs:setSprite(self.legs_path .. name .. "_" .. number)
        end
end

function vessel_legs:update_part()
    local spr = self.vessel.sprite_options[1]
    local walk = self.vessel.sprite_options[3]
    local legs = self.legs_sprite

    local frame = tonumber(spr:match("_(%d+)")) 
    local name = spr:match("^(.*)_") or spr

    if legs[name] then
        self:part_set(legs, name, frame, walk)
    else
        local frames = Assets.getFrames(self.legs_path .. name)
        if frames then
            legs[name] = #frames
        else
            legs[name] = 1
        end
        self:part_set(legs, name, frame, walk)
    end

    local offset = self.offsets[name] or {0, 0}
    legs.x, legs.y = offset[1], offset[2]
    
end

return vessel_legs