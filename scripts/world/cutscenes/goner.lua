return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    test = function(cutscene, event)
        -- There is no better way to do this. suffer.
        
        local function gonertext(text,x_offset,y_offset,persist,waitfor)
            text = DialogueText("[speed:0.5][spacing:8][voice:none]" .. text, 0 + x_offset, 120 + y_offset, SCREEN_WIDTH, SCREEN_HEIGHT, {style = "GONER", line_offset = 12, align = "center"})
            text.layer = WORLD_LAYERS["textbox"]
            text.can_advance = false
            text.align = "center"
            text.skip_speed = true
            local fade = 0
            Game.stage:addChild(text)
            if not persist then
                cutscene:wait(function () return not text:isTyping() end)
                cutscene:wait(0.75)
                text:advance()
                cutscene:wait(function () return text:isDone() end)
                cutscene:during(function ()
                    if fade < 1 then
                        fade = fade + DTMULT * 0.05
                        text:setColor(1, 1, 1, 1 - fade)
                    end
                end)
                cutscene:wait(function () return fade >= 1 end)
                Game.stage:removeChild(text)
                cutscene:wait(0.75)
            else
                cutscene:wait(waitfor)
                cutscene:during(function ()
                    if fade < 1 then
                        fade = fade + DTMULT * 0.05
                        text:setColor(1, 1, 1, 1 - fade)
                    end
                end)
                cutscene:wait(function () return fade >= 1 end)
                Game.stage:removeChild(text)
                cutscene:wait(0.75)

            end
        end

        local function gonertext2(text,x_offset,y_offset)
            text = DialogueText("[speed:0.25][voice:none]" .. text, 160 + x_offset, 120 + y_offset, SCREEN_WIDTH, SCREEN_HEIGHT, {style = "none",line_offset = 12})
            text.layer = WORLD_LAYERS["textbox"]
            text.can_advance = false
            text.skippable = false
            text.align = "center"
            text.skip_speed = true
            local fade = 0
            Game.stage:addChild(text)

            cutscene:wait(function () return not text:isTyping() end)
            cutscene:wait(3)
            text:advance()
            cutscene:wait(function () return text:isDone() end)
            cutscene:during(function ()
                if fade < 1 then
                    fade = fade + DTMULT * 0.0125
                    text:setColor(1, 1, 1, 1 - fade)
                end
            end)
            cutscene:wait(function () return fade >= 1 end)
            Game.stage:removeChild(text)
            cutscene:wait(2)

        end

        local function gonerchoicer(headertext,x_text,y_text,x_choicer,y_choicer,choices,on_complete,on_select)
            local choicer = GonerChoice(x_choicer,y_choicer,choices,on_complete,on_select)
            choicer.layer = WORLD_LAYERS["textbox"]
            choicer:setSoulOffset(-50, 0)
            choicer:setSoulPosition(-50,0)
            Game.stage:addChild(choicer)
            gonertext(headertext,x_text,y_text,true,function () return choicer.done end)
            return choicer.choice
        end
        local crash_names = {
            "GASTER"
        }
        local deny_names = {
            "BERDLY",
            "TORIEL",
            "ASRIEL",
            "ASGORE",
            "SANS",
            "PAPYRUS",
            "ALPHYS",
            "UNDYNE",
            "RUDY",
            "CATTY",
            "CATTI",
            "BRATTY",
            "GERSON",
            "JOCKINGTON",
            "QC"

        }
        local unique_names = {
            "SUSIE",
            "KRIS",
            "NOELLE",
            "CESAR",
            "SKUNKY",
        }
        love.window.setTitle("CONTACT")
        Game:setBorder("none")
        cutscene:fadeOut (0, {music = false})
        Game.world.music:play("AUDIO_DRONE")
        cutscene:wait(4)
        --Kristal.setDesiredWindowTitleAndIcon()
        gonertext("ARE YOU\n[wait:30]THERE?",0,-20,false)
        gonertext("ARE WE\n[wait:30]CONNECTED?",0,-20,false)

        local soul = SoulAppearance(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
        soul:setParallax(0, 0)
        soul.layer = WORLD_LAYERS["top"] + 100
        Game.world:addChild(soul)
        local soul_timer = 0
        local soul_should_move = false
        cutscene:during(function ()
            if soul_should_move then
                soul_timer = soul_timer + DTMULT
                soul.y = soul.init_y + math.sin(soul_timer / 16) * 2 * 2
            end
        end)
        cutscene:wait(20/30)
        soul_should_move = true
        cutscene:wait(2)

        gonertext("EXCELLENT.",0,-20)
        gonertext("TRULY\n[wait:30]EXCELLENT.",0,-20,false)
        gonertext("NOW.",0,-20)
        gonertext("WE MAY\n[wait:30]BEGIN.",0,-20,false)
        soul:hide()
        cutscene:wait(2)
        Game.world.music:stop()
        local background = GonerBackground()
        background.layer = WORLD_LAYERS["top"]
        Game.world:addChild(background)
        cutscene:wait(4)

        gonertext("FIRST.",0,-20)
        gonertext("YOU MUST CREATE\n[wait:30]A VESSEL.",0,-20,false)

        cutscene:wait(1)
        gonertext("IN THIS WORLD,\n[wait:30]THERE ARE TWO RACES.",0,-20,false)
        
        gonertext("HUMAN, [wait:15]AND MONSTER.",0,-20,false)

        local monster = false

        local gonermakerchoicer = gonerchoicer(
                "WHICH DO YOU PREFER?",0,0,
                220,360,
                {
                    {
                        { "HUMAN", -50, 0 },
                        { "<<" },
                        { ">>" },
                        { "MONSTER", 160, 0 }
                    }
                },
                nil,
                nil
            )
            if gonermakerchoicer == "HUMAN" then
                monster = false
            elseif gonermakerchoicer == "MONSTER" then
                monster = true
            end
        
        local function makersection()
            local maker = GonerMaker(90, 80, monster)
            maker.layer = WORLD_LAYERS["top"] + 101
            maker.s = 0
            maker.STEP = 1
            Game.world:addChild(maker)
            gonertext("SELECT THE HEAD\nTHAT YOU PREFER.",0,-40,true,function () return maker.FINISH == 1 end)

            local maker = GonerMaker(90, 80, monster)
            maker.layer = WORLD_LAYERS["top"] + 100
            maker.s = 1
            maker.STEP = 2
            Game.world:addChild(maker)
            gonertext("SELECT THE TORSO\nTHAT YOU PREFER.",0,-40,true,function () return maker.FINISH == 1 end)
            local maker = GonerMaker(90, 80, monster)
            maker.layer = WORLD_LAYERS["top"] + 100
            maker.s = 2
            maker.STEP = 3
            Game.world:addChild(maker)
            gonertext("SELECT THE LEGS\nTHAT YOU PREFER.",0,-40,true,function () return maker.FINISH == 1 end)
            local maker = GonerMaker(90, 60, monster)
            maker.layer = WORLD_LAYERS["top"] + 100
            maker.CANCEL = 1
            maker.FINISH = -1
            maker.s = -1
            maker.STEP = 3
            Game.world:addChild(maker)
            gonertext("THIS[wait:30] IS YOUR BODY.",0,-20,false)
            local gonermakerchoicer = gonerchoicer(
                "DO YOU ACCEPT IT?",0,0,
                220,360,
                {
                    {
                        { "NO", 0, 0 },
                        { "<<" },
                        { ">>" },
                        { "YES", 160, 0 }
                    }
                },
                nil,
                nil
            )
            if gonermakerchoicer == "YES" then

            elseif gonermakerchoicer == "NO" then
                maker.FINISH = 1
                cutscene:wait(1)
                makersection()
            end
            return maker
        end
        local maker = makersection()
        gonertext("EXCELLENT.",0,-20,false)
        gonertext("YOU HAVE CREATED\n[wait:30]A WONDERFUL FORM.",0,-20,false)
        gonertext("NOW.",0,-20,false)
        gonertext("LET US SHAPE ITS\nMIND[wait:30] AS YOUR OWN.",0,-20,false)
        cutscene:during(function ()
            if maker.init_x < 120 then
                maker.init_x = maker.init_x + (DTMULT * 0.5)
            else
                return false
            end
        end)
        cutscene:during(function ()
            if maker.init_y < 80 then
                maker.init_y = maker.init_y + (DTMULT * 0.5)
            else
                return false
            end
        end)
            local favoritefood = gonerchoicer(
                "WHAT IS ITS\nFAVORITE FOOD?",0,-20,
                160,200,
                {
                    { { "SWEET", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "SOFT",0,40} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "SOUR",0,80} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "SALTY",0,120} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "PAIN",0,160} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "COLD",0,200} }
                },
                nil,
                nil
            )
            if favoritefood == "SWEET" then
                Game:setFlag("favorite_food", "sweet")
            elseif favoritefood == "SOFT" then
                Game:setFlag("favorite_food", "soft")
            elseif favoritefood == "SOUR" then
                Game:setFlag("favorite_food", "sour")
            elseif favoritefood == "SALTY" then
                Game:setFlag("favorite_food", "salty")
            elseif favoritefood == "PAIN" then
                Game:setFlag("favorite_food", "pain")
            elseif favoritefood == "COLD" then
                Game:setFlag("favorite_food", "cold")
            end

            local favoritebloodtype = gonerchoicer(
                "YOUR FAVORITE\nBLOOD TYPE?",0,0,
                160,250,
                {
                    { { "A", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "AB",0,40} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "B",0,80} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "C",0,120} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "D",0,160} }
                },
                nil,
                nil
            )
            if favoritebloodtype == "A" then
                Game:setFlag("favorite_blood_type", "a")
            elseif favoritebloodtype == "AB" then
                Game:setFlag("favorite_blood_type", "ab")
            elseif favoritebloodtype == "B" then
                Game:setFlag("favorite_blood_type", "b")
            elseif favoritebloodtype == "C" then
                Game:setFlag("favorite_blood_type", "c")
            elseif favoritebloodtype == "D" then
                Game:setFlag("favorite_blood_type", "d")
            end

            local favoritecolor = gonerchoicer(
                "WHAT COLOR DOES\nIT LIKE THE MOST?",0,0,
                160,250,
                {
                    { { "RED", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "BLUE",0,40} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "GREEN",0,80} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "CYAN",0,120} }
                },
                nil,
                nil
            )
            if favoritecolor == "RED" then
                Game:setFlag("favorite_color", "red")
            elseif favoritecolor == "BLUE" then
                Game:setFlag("favorite_color", "blue")
            elseif favoritecolor == "GREEN" then
                Game:setFlag("favorite_color", "green")
            elseif favoritecolor == "CYAN" then
                Game:setFlag("favorite_color", "cyan")
            end

            local gift = gonerchoicer(
                "PLEASE GIVE IT\nA GIFT.",0,0,
                160,250,
                {
                    { { "KINDNESS", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "MIND",0,40} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "AMBITION",0,80} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "BRAVERY",0,120} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "VOICE",0,160} }
                },
                nil,
                nil
            )
            if gift == "KINDNESS" then
                Game:setFlag("gift", "kindness")
            elseif gift == "MIND" then
                Game:setFlag("gift", "mind")
            elseif gift == "AMBITION" then
                Game:setFlag("gift", "ambition")
            elseif gift == "BRAVERY" then
                Game:setFlag("gift", "bravery")
            elseif gift == "VOICE" then
                Game:setFlag("gift", "voice")
            end

            local feeling = gonerchoicer(
                "HOW DO YOU FEEL\nABOUT YOUR CREATION?\n(IT WILL NOT HEAR.)",0,0,
                160,250,
                {
                    { { "LOVE", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "HOPE",0,40} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "DISGUST",0,80} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "FEAR",0,120} }
                },
                nil,
                nil
            )
            if feeling == "LOVE" then
                Game:setFlag("feeling", "love")
            elseif feeling == "HOPE" then
                Game:setFlag("feeling", "hope")
            elseif feeling == "DISGUST" then
                Game:setFlag("feeling", "disgust")
            elseif feeling == "FEAR" then
                Game:setFlag("feeling", "fear")
            end

            local honesty = gonerchoicer(
                "HAVE YOU ANSWERED\nHONESTLY?",0,0,
                160,250,
                {
                    { { "YES", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "NO",0,40} }
                },
                nil,
                nil
            )
            if honesty == "YES" then
                Game:setFlag("honesty", true)
            elseif honesty == "NO" then
                Game:setFlag("honesty", false)
            end

            local acknowledgement = gonerchoicer(
                "YOU ACKNOWLEDGE\nTHE POSSIBILITY OF\nPAIN AND SEIZURE?",0,0,
                160,250,
                {
                    { { "YES", 0,0} },
                    { {"^^"} },
                    { {"vv"} },
                    { { "NO",0,40} }
                },
                nil,
                nil
            )
            if acknowledgement == "YES" then
                Game:setFlag("acknowledgement", true)
            elseif acknowledgement == "NO" then
                Game:setFlag("acknowledgement", false)
            end
        cutscene:during(function ()
            if maker.init_x > 90 then
                maker.init_x = maker.init_x - (DTMULT * 0.5)
            else
                return false
            end
        end)
        cutscene:during(function ()
            if maker.init_y < 100 then
                maker.init_y = maker.init_y + (DTMULT * 0.5)
            else
                return false
            end
        end)
        cutscene:during(function ()
            if maker.color[1] > 0 then
                maker.color[1] = maker.color[1] - (DTMULT * 0.05)
                maker.color[2] = maker.color[2] - (DTMULT * 0.05)
                maker.color[3] = maker.color[3] - (DTMULT * 0.05)
            else
                return false
            end
        end)
        gonertext("UNDERSTOOD.",0,0,false)
        local name
        local found = nil
        local keyboard = GonerKeyboard(
            12,
            "default",
            function(text)
                name = text
                for _, v in pairs(crash_names) do
                    if text == v then
                        love.event.quit("restart")
                    end
                end
                for _, v in pairs(deny_names) do
                    if text == v then
                        found = 1
                    end
                end
                for _, v in pairs(unique_names) do
                    if text == v then
                        found = 2
                    end
                end
            end
        )
        keyboard.limit = 6
        Game.stage:addChild(keyboard)

        gonertext("NAME YOUR VESSEL.",0,-80,true,function () return keyboard.done end)
        cutscene:wait(function () return keyboard.done end)
        cutscene:during(function ()
            if maker.color[1] < 1 then
                maker.color[1] = maker.color[1] + (DTMULT * 0.05)
                maker.color[2] = maker.color[2] + (DTMULT * 0.05)
                maker.color[3] = maker.color[3] + (DTMULT * 0.05)
            else
                return false
            end
        end)
        Game:setFlag("name", name)
        gonertext("WE CALLED IT\n" .. "'" .. name .. ".'",0,0,false)
        if found == 1 or found == 2 then
            gonertext("AN INTERESTING\nCOINCIDENCE.",0,0,false)
            found = 0
        end

        gonertext("AND WHAT ABOUT\nTHE CREATOR?",0,0,false)
        cutscene:during(function ()
            if maker.color[1] > 0 then
                maker.color[1] = maker.color[1] - (DTMULT * 0.05)
                maker.color[2] = maker.color[2] - (DTMULT * 0.05)
                maker.color[3] = maker.color[3] - (DTMULT * 0.05)
            else
                return false
            end
        end)
        local truename
        local keyboard2 = GonerKeyboard(
            12,
            "default",
            function(text)
                truename = text
                for _, v in pairs(crash_names) do
                    if text == v then
                        love.event.quit("restart")
                    end
                end
                for _, v in pairs(deny_names) do
                    if text == v then
                        found = 1
                    end
                end
                for _, v in pairs(unique_names) do
                    if text == v then
                        found = 2
                    end
                end
            end
        )
        keyboard2.limit = 6
        Game.stage:addChild(keyboard2)

        gonertext("YOUR OWN NAME.",0,-80,true,function () return keyboard2.done end)
        cutscene:wait(function () return keyboard2.done end)
        cutscene:during(function ()
            if maker.color[1] < 1 then
                maker.color[1] = maker.color[1] + (DTMULT * 0.05)
                maker.color[2] = maker.color[2] + (DTMULT * 0.05)
                maker.color[3] = maker.color[3] + (DTMULT * 0.05)
            else
                return false
            end
        end)
        Game.save_name = truename

        gonertext("'"..Game.save_name..".'",0,0,false)
        if name == truename then
            gonertext("OF COURSE\n[wait:30]OF COURSE.",0,0,false)
            gonertext("OF COURSE\nTHEY[wait:30] ARE THE SAME.",0,0,false)
        elseif found == 1 then
            gonertext("HOW INTERESTING.",0,0,false)
            gonertext("TRULY\n[wait:30]EXCELLENT.",0,0,false)
        elseif found == 2 then
            gonertext("YOU ARE ABOUT TO\nMEET SOMEONE",0,0,false)
            gonertext("VERY, VERY\nWONDERFUL.",0,0,false)
        else
            gonertext("EXCELLENT.",0,0,false)
            gonertext("TRULY\n[wait:30]EXCELLENT.",0,0,false)
        end
        gonertext("'"..Game.save_name..".'",0,0,false)
        gonertext("THANK YOU\n[wait:30]FOR YOUR TIME.",0,0,false)
        gonertext("YOUR ANSWERS",0,0,false)
        gonertext("YOUR WONDERFUL\n[wait:30]CREATION",0,0,false)
        if Game:getFlag("legs", 0) < 5 then
            Game:setFlag("legs",1)
        elseif Game:getFlag("legs", 0) == 5 then
            Game:setFlag("legs",2)
        end
        local fixedname = StringUtils.titleCase(name)
        Game:setFlag("name", fixedname)
        love.window.setTitle(" ")
        background.music:stop()
        Game.world:removeChild(background)
        Game.world:removeChild(maker)
        Assets.playSound("voice/default")
        cutscene:wait(0.5)
        gonertext2("Will now be\n[wait:30]discarded.",0,0)
        gonertext2("No one can choose\n[wait:30]who they are in this world.",0,0)
        cutscene:fadeOut(1)
        cutscene:wait(1)
        cutscene:mapTransition("intro")
    end
}
