local spell, super = Class(Spell, "frost_bloom")

function spell:init()
    super.init(self)
end

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Frost Bloom"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Ice\nEnemy"
    -- Menu description
    self.description = "Freezes an enemy, reducing their attack and defense."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"ice"}
end

function spell:onCast(user, target)
    Game.battle.timer:script(function(wait)  
        local spr = Sprite("effects/frostbloom")
        spr:setScale(2)
        spr:setOrigin(0.5, 1)
        local x, y = target:getScreenPos()
        spr.layer = target.layer + 1
        Game.battle:addChild(spr)
        spr:setPosition(x, y + 5)
        spr:play(1/20, false)
        Assets.playSound("HarpNoise", 1.0, 1.0)


        local color = ColorMaskFX(COLORS.blue)
        color.amount = 0
        spr:addFX(color)
        Assets.playSound("PowerUp", 1.0, 0.8)
        Game.battle.timer:tween(1, color, {amount = 1}, "linear")
        wait(1.65)
        spr:removeFX(color)
        spr:setSprite("effects/ice")
        spr.y = spr.y + 5
        spr:play(1/15, false)
        Assets.playSound("Ice", 1.0, 1.0)
        wait(17/15)
        spr:remove()
        Assets.playSound("damage", 1.0, 1.0)
        target:hurt(35, user)
       for i = 0, 5 do
                local effect = IceSpellEffect(target.x , target.y - 35)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["above_battlers"] - 1
                Game.battle:addChild(effect)
            end
        
        
        Game.battle:finishAction()
    end)
    return false
end
return spell