local spell, super = Class(Spell, "spikes")

function spell:init()
    super.init(self)
end

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Spikes"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Damage\nEnemy"
    -- Menu description
    self.description = "Sharp vine spikes that wrap around an enemy, dealing damage."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"vines"}
end

function spell:onCast(user, target)
    Game.battle.timer:script(function(wait)  
        local spr = Sprite("effects/spikes")
        spr:setScale(2)
        spr:setOrigin(0.5, 1)
        local x, y = target:getScreenPos()
        spr.layer = target.layer + 1
        Game.battle:addChild(spr)
        spr:setPosition(x, y + 5) 
        Assets.playSound("HarpNoise", 1.0, 1.0)
        for i = 1, 11 do
            spr:setFrame(i)
            wait (1/15)
        end

      wait(1) 
      Assets.playSound("Spikes", 1.0, 1.0)
        spr:setFrame(12)
        wait(1/15)
        spr:setFrame(13)
       
        spr:remove()
        Assets.playSound("damage", 1.0, 1.0)
        target:hurt(25, user)
        
        
      
       Game.battle:finishAction()
    end)
    return false
end
return spell