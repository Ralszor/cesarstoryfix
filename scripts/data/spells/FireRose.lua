local spell, super = Class(Spell, "fire_rose")

function spell:init()
    super.init(self)
end

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Fire Rose"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Fire\nEnemy"
    -- Menu description
    self.description = "A rose of fire engulfs the target, dealing fire damage."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"fire"}
end

function spell:onCast(user, target)
    Game.battle.timer:script(function(wait)  
        local spr = Sprite("effects/firerose")
        spr:setScale(2)
        spr:setOrigin(0.5, 1)
        local x, y = target:getScreenPos()
        spr.layer = target.layer + 1
        Game.battle:addChild(spr)
        spr:setPosition(x, y + 5)
        spr:play(1/20, false)
        Assets.playSound("HarpNoise", 1.0, 1.0)

        local color = ColorMaskFX(COLORS.red)
        color.amount = 0
        spr:addFX(color)
        Assets.playSound("PowerUp", 1.0, 0.8)
        Game.battle.timer:tween(1, color, {amount = 1}, "linear")
        wait(1.65)
        spr:removeFX(color)
        spr:setSprite("effects/fire")
        spr:play(1/15, false)
        Assets.playSound("Fire", 1.0, 1.0)
        wait(17/15)
        spr:remove()
        Assets.playSound("damage", 1.0, 1.0)
        target:hurt(40, user)
        
        
        
        
        
        
        
        Game.battle:finishAction()
    end)
    return false
end
return spell