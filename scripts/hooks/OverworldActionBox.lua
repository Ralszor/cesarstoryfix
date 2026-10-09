local OverworldActionBox, super = Utils.hookScript(OverworldActionBox)

function OverworldActionBox:init(...)
  super.init(self, ...)
  if self.name_sprite and self.chara.name == "Skunky" then
    self.name_sprite.x = self.name_sprite.x - 8
  end
end

return OverworldActionBox