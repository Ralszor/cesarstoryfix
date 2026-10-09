local spell, super = Class(Spell, "self_destruct")

function spell:init()
    super.init(self)
end

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Self Destruct"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Fire\nEnemy"
    -- Menu description
    self.description = "Self sacrifice, channeled through the user's own being and power."

    -- TP cost
    self.cost = 100

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"damage"}
end
function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("devilsknife") then
        cost = cost - 10
    end
    return cost
end

function spell:onCast(user, target)
    local buster_finished = false
    local anim_finished = false
    local function finishAnim()
        anim_finished = true
        if buster_finished then
            Game.battle:finishAction()
        end
    end
    if not user:setAnimation("effects/selfdestruct", finishAnim) then
        anim_finished = false
        user:setAnimation("effects/selfdestruct", finishAnim)
    end
    Game.battle.timer:after(15/30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = SelfDestruct(true, x, y, tx, ty, function(damage_bonus, play_sound)
            local damage = self:getDamage(user, target, damage_bonus)
                Assets.playSound("Fire")
        
          
            user:hurt(user.chara.health - 1, true)
            target:flash()
            target:hurt(damage, user)
            buster_finished = true
            if anim_finished then

                   
                

                Game.battle:finishAction()
            end
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)
    end)
    return false
end

function spell:getDamage(user, target, damage_bonus)
    local damage = math.ceil(((user.chara:getStat("magic") + 1) * 10) * (user.chara:getStat("attack") * 11)) + damage_bonus
    return damage
end


return spell