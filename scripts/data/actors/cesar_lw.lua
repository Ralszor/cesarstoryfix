local actor, super = Class(Actor, "cesar_lw")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Cesar"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 37

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = {10, 24}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/cesar/light"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "cesar"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/cesar"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-10, -22}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Cutscene animations
        ["sit"] = {"sit", 0.25, true},
        ["slide"] = {"slide", 0.25, true},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Cutscene offsets
        ["fall"] = {-8, -2},
        ["shocked"] = {0, 1},
        ["shocked_blush"] = {0, 1},
        ["shocked_blush_lefty"] = {0, 1},
        ["fallen"] = {-8, 16},

        ["sit"] = {-4, -8},
        
        ["slide"] = {0, 0},

        ["ghostwalk_lf"] = {-4, 3},
        ["ghostwalk_lu"] = {-4, 3},
        ["ghostwalk_rf"] = {-4, 3},
        ["ghostwalk_ru"] = {-4, 3},
    }
end

return actor
