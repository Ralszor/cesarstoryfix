return {
    desk = function(cutscene)
        cutscene:text("* It's my computer. I feel like I haven't used it in forever...")
       local ch = cutscene:choicer({"Search history", "Search cookies", "Search plants", "Exit"})
       local cesar = cutscene:getCharacter("cesar")

        if ch == 1 then
            cutscene:text("* You look through your search history...")
            cesar:setSprite("shocked")
            cutscene:text("* ...")
            cesar:setSprite("shocked_blush")
            cutscene:text("* You feel your face turning red.")
            cutscene:text("* Ah, dammit!", "Shocked", cesar)
            cesar:setSprite("shocked_blush_left")
            Assets.playSound("wing")
            cutscene:wait(1/10)
            cesar:resetSprite()
            cesar:setFacing("up")
            cutscene:text("* You immediately look away, pretending you saw nothing.")
            return
        elseif ch == 2 then
            cutscene:text("* You searched up images of cookies.[wait:10] You see thousands of cookie images.")
            cutscene:text("* You feel like eating the screen just by seeing these pictures.")
            cutscene:text("* Boy, these look delicious![wait:10] It's making me hungry!", "Happy", cesar)
            return
        elseif ch == 3 then
            cutscene:text("* You searched up images of plants.[wait:10] You see thousands of plant images.")
            cutscene:text("* You see some sunflowers.[wait:10] Seeing these makes you smile.")
            cutscene:text("* Aww! These are so cute![wait:10] I have to tell dad to plant more of them!", "Happy", cesar)
            return
        else
        return
        end
    end
     }