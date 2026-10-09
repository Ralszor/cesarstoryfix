local vessel_torso, super = Class(Object)

function vessel_torso:init(vessel, data)
    super:init(self)
    self.vessel = vessel

    self.torso_sprite = Sprite("vessel/torsos/"..data.torso.."/"..self.vessel.sprite_options[2])
    self:addChild(self.torso_sprite)
     
    self.torso_path = "vessel/torsos/"..data.torso.."/"

    print(data.torso)

    self.offsets = {
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0}
    }
end


function vessel_torso:part_set(torso, name, frame, walk)

        if torso[name] == 1 then
            torso:setSprite(self.torso_path .. name)
        else
            local number = (frame - 1) % torso[name] + 1 
            if number == 3 and walk == "walk" then number = 1 end
            torso:setSprite(self.torso_path .. name .. "_" .. number)
        end
end

function vessel_torso:update_part()
    local spr = self.vessel.sprite_options[1]
    local walk = self.vessel.sprite_options[3]
    local torso = self.torso_sprite

    local frame = tonumber(spr:match("_(%d+)")) 
    local name = spr:match("^(.*)_") or spr

    if torso[name] then
        self:part_set(torso, name, frame, walk)
    else
        local frames = Assets.getFrames(self.torso_path .. name)
        if frames then
            torso[name] = #frames
        else
            torso[name] = 1
        end
        self:part_set(torso, name, frame, walk)
    end

    local offset = self.offsets[name] or {0, 0}
    torso.x, torso.y = offset[1], offset[2]
    
end

return vessel_torso