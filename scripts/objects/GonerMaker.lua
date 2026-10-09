---@class GonerMaker : Object
---@overload fun(...) : GonerMaker
local GonerMaker, super = Class(Object)

function GonerMaker:init(x, y, monster)
    super.init(self, x, y)

    self:setScale(2)
    self:setOrigin(0.5, 0.5)
    self.sizes = {
        [1] = "DEFAULT",
        [2] = "MC",
        [3] = "C",
        [4] = "MS"
    }
    self.monster = monster or false

    self.siner = 0
    self:setSprite("world/GONERMAKER/IMAGE_GONERHEAD_1")
    self.HEAD = 0
    self.BODY = 0
    self.LEGS = 0
    self.HEADMAX = 8
    self.BODYMAX = 6
    self.LEGSMAX = 2
    self.PART = {}
    self.PART[0] = Game:getFlag("head", 0)
    self.PART[1] = Game:getFlag("torso", 0)
    self.PART[2] = Game:getFlag("legs", 0)
    self.PARTMAX = {}
    self.PARTMAX[0] = self.HEADMAX
    self.PARTMAX[1] = self.BODYMAX
    self.PARTMAX[2] = 5
    self.s = 0
    self.PARTX = {}
    self.IDEALX = {}
    self.PARTX[0] = 0;
    self.IDEALX[0] = 0;
    self.PARTX[1] = 0;
    self.IDEALX[1] = 0;
    self.PARTX[2] = 0;
    self.IDEALX[2] = 0;
    for i = 0, 2 do
        self.IDEALX[i] = self.PART[i] * -50;
        self.PARTX[i] = self.IDEALX[i];
    end
    self.LOCK = {}
    self.LOCK[0] = 0
    self.LOCK[1] = 0
    self.LOCK[2] = 0
    self.FINISH = 0
    self.ONEBUFFER = 10
    self.CANCEL = 0
    self.FADEBUFFER = 10
    self.STEP = 1
    self.NAMEFADE = 0
    self.OFFX = 0
    self.SY = {}
    self.SY[0] = -2
    self.SY[1] = 34
    self.SY[2] = 60
    self.timer = Timer()
    self.color = {}
    self.color[1] = 1
    self.color[2] = 1
    self.color[3] = 1
    -- Evil variable pls ignore
    self.part_center_x = 20
 


end

function GonerMaker:update()
    super.update(self)
    self.siner = self.siner + DTMULT
    self.x = self.init_x + (math.sin(self.siner / 24) * 2);
    self.y = self.init_y + (math.cos(self.siner / 30) * 2);

    if self.FINISH == 0 and self.ONEBUFFER < 0 and self.CANCEL == 0 then
        if Input.pressed("left", true) then
            self.PART[self.s] = self.PART[self.s] - 1
        end

        if Input.pressed("right", true) then
            self.PART[self.s] = self.PART[self.s] + 1
        end

        if Input.pressed("confirm") and self.LOCK[self.s] == 1 then
            self.FINISH = 1;
            if self.s == 0 then
                Game:setFlag("head", self.PART[self.s])
                if self.PART[self.s] == 7 then 
                end
            elseif self.s == 1 then
                Game:setFlag("torso", self.PART[self.s])
            elseif self.s == 2 then
                Game:setFlag("legs", self.PART[self.s])
            end
        end
    end
    for i = 0, 2 do
        if self.PART[i] > self.PARTMAX[i] then
            self.PART[i] = self.PARTMAX[i];
        end
        
        if self.PART[i] < 1 then
            self.PART[i] = 1;
        end
        
        self.IDEALX[i] = (self.PART[i] * -50);
        
        if self.PARTX[i] < self.IDEALX[i] then
            if math.abs(self.IDEALX[i] - self.PARTX[i]) >= 0 then
                self.PARTX[i] = self.PARTX[i] + (10)
            end
            
            if math.abs(self.IDEALX[i] - self.PARTX[i]) > 100 then
                self.PARTX[i] = self.PARTX[i] + (10)
            end
            
            if math.abs(self.IDEALX[i] - self.PARTX[i]) > 150 then
                self.PARTX[i] = self.PARTX[i] + (10)
            end
        end
        
        if self.PARTX[i] > self.IDEALX[i] then
            if math.abs(self.IDEALX[i] - self.PARTX[i]) >= 0 then
                self.PARTX[i] = self.PARTX[i] - (10)
            end
            
            if math.abs(self.IDEALX[i] - self.PARTX[i]) > 50 then
                self.PARTX[i] = self.PARTX[i] - (10)
            end
            
            if math.abs(self.IDEALX[i] - self.PARTX[i]) > 100 then
                self.PARTX[i] = self.PARTX[i] - (10)
            end
            
            if math.abs(self.IDEALX[i] - self.PARTX[i]) > 150 then
                self.PARTX[i] = self.PARTX[i] - (10)
            end
        end
        if self.PARTX[i] == self.IDEALX[i] then
            self.LOCK[i] = 1;
        else
            self.LOCK[i] = 0;
        end
    end

    self.ONEBUFFER = self.ONEBUFFER - DTMULT;

    if self.FADEBUFFER > 0 and self.FINISH <= 0 then
        self.FADEBUFFER = self.FADEBUFFER - DTMULT;
    end
    if self.FINISH == 1 then
        self.FADEBUFFER = self.FADEBUFFER + DTMULT;
    end
    if self.FADEBUFFER > 10 then
        self:remove()
    end

end

function GonerMaker:getCenteredOrigin(texture)
    return texture:getWidth() / 2
end

function GonerMaker:draw()
    super.draw(self)
    local flag = Game:getFlag("size", 1)
    local size = self.sizes[flag]

    local FA = (10 - self.FADEBUFFER) / 10
    if FA > 1 then
        FA = 1
    end

    for k = self.STEP - 1, 0, -1 do
        
        local m = self.monster and "MONSTER" or "GONER"
        local img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m.."HEAD")
        if k == 1 then
            local ending = self.monster and "BODY"..size or "BODY"
            img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m..ending)
        end

        if k == 2 then
            local ending = self.monster and "LEGS"..size or "LEGS"
            img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m..ending)
        end
        if (self.LOCK[k] == 1) then
            Draw.setColor(1, 1, 1, 0.4 * FA)
            local s_size = math.abs(math.sin(self.siner / 16) / 2)
            local offset = self:getCenteredOrigin(img[self.PART[k]])
            --Draw.draw(self.dust[1], math.sin(self.siner / 5), math.sin(self.siner / 5), 0, 2, 2)
            Draw.draw(img[self.PART[k]], self.x + self.part_center_x + ((s_size * self.width) / 2), (self.y + self.SY[k]) + ((s_size * self.height) / 2), 0, 2, 2, offset, 0)
            s_size = math.abs(math.sin(self.siner / 21) / 2)
            Draw.draw(img[self.PART[k]], self.x + self.part_center_x - ((s_size * self.width) / 2), (self.y + self.SY[k]) - ((s_size * self.height) / 2), 0, 2, 2, offset, 0)
        end

        self.timer:every(1/15, function()
            local after_image = AfterImage(img[self.PART[k]], 0.4, 0.04)
            self:addChild(after_image)
        end)    

    end
    if (self.CANCEL == 0) then
        Draw.setColor(1, 0, 0, 1 * FA)
        Draw.draw(Assets.getTexture("player/heart_blur"), self.init_x + 10, self.init_y - 30, 0,1,1);
    end

    for j = self.STEP - 1, 0, -1 do
        local m = self.monster and "MONSTER" or "GONER"
        local img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m.."HEAD")
        
        if j == 1 then
            local ending = self.monster and "BODY"..size or "BODY"
            img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m..ending)
        end
        
        if j == 2 then
            local ending = self.monster and "LEGS"..size or "LEGS"
            img = Assets.getFramesOrTexture("world/GONERMAKER/IMAGE_"..m..ending)
        end
        
        if self.s == j then
            for i = 1, self.PARTMAX[j] do
                local alpha = 1 - (math.abs(self.PARTX[j] + (i * 50)) / 120);
                Draw.setColor(self.color[1], self.color[2], self.color[3], alpha * FA)
                local offset = self:getCenteredOrigin(img[i])
                Draw.draw(img[i], self.x + self.part_center_x + self.PARTX[j] + (i * 50), self.y + self.SY[j], 0,2,2, offset, 0);
            end
        else
            local offset = self:getCenteredOrigin(img[self.PART[j]])
            Draw.setColor(self.color[1], self.color[2], self.color[3], 1 * FA)
            Draw.draw(img[self.PART[j]], self.x + self.part_center_x, self.y + self.SY[j], 0,2,2, offset, 0);
        end
    end

    self.NAMEFADE_COMPLETE = 0;
    if self.NAMEFADE_COMPLETE == 0 then
        self.NAMEFADE = (self.NAMEFADE - 0.03) * DTMULT;
        self.NAMEFADE = (self.NAMEFADE * 0.75) * DTMULT;

        if self.NAMEFADE <= 0 then
            self.NAMEFADE = 0;
        end
    end
end

function GonerMaker:setSprite(sprite)
    if type(sprite) == "string" then
        sprite = Assets.getTexture(sprite)
    end

    self.sprite = sprite
    self.width = 10
    self.height = 10
end

return GonerMaker
