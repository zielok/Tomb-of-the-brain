import 'globals.lua'

local gfx = playdate.graphics

--playdate.display.setRefreshRate(0)

function playdate.update()
    gfx.setBackgroundColor(gfx.kColorClear)

    if (gameState=='initTitle') then
        TitleScreen:init()
        gameState='title'
    elseif (gameState=='title') then
        TitleScreen:draw()
        if playdate.buttonJustPressed("a") then
            sclick:play()
            Prelevel:init()
            FadeModule:setup1()
            Prelevel:drawFull()
            FadeModule:setup2()
            gameState='prelevel'
            sprelevel:play()
            removeSysMenu()
        elseif playdate.buttonJustPressed("b") then
            sreset:play()
            runda = 1
            Game:saveGameData()
        end
    elseif (gameState=='prelevel') then
        if (FadeModule.finish==0) then
            FadeModule:updateFade(15)
        end
        if (FadeModule.finish==1 and playdate.buttonJustPressed("a")) then
            sclick:play()
            Game:init()
            FadeModule:setup1()
            Game:drawFull()
            FadeModule:setup2()
            gameState='game'
        end
    elseif (gameState=='levelnext') then
        FadeModule:setup1()
        Prelevel:drawFull()
        FadeModule:setup2()
        gameState='prelevel'
        removeSysMenu()
    elseif (gameState=='completeinit') then
        slevelcomplete:play()
        Complete:init()
        FadeModule:setup1()
        Complete:drawFull()
        FadeModule:setup2()
        gameState='complete'
    elseif (gameState=='overinit') then
        slevelbad:play()
        Over:init()
        FadeModule:setup1()
        Over:drawFull()
        FadeModule:setup2()
        gameState='over'
    elseif (gameState=='game') then
        if (FadeModule.finish==0) then
            FadeModule:updateFade(15)
        end
            if (FadeModule.finish==1) then 
                Game:update()
                Game:drawFull()
        end
    elseif (gameState=='over') then
        if (FadeModule.finish==0) then
            FadeModule:updateFade(15)
        end
        if (FadeModule.finish==1) then 
            Over:drawFull()
            if (playdate.buttonJustPressed("a")) then
                FadeModule:setup1()
                Prelevel:drawFull()
                FadeModule:setup2()
                gameState='prelevel'
                removeSysMenu()
                sprelevel:play()
            elseif (playdate.buttonJustPressed("b")) then
                gameState='initTitle'
            end
        end
    elseif (gameState=='complete') then
        if (FadeModule.finish==0) then
            FadeModule:updateFade(15)
        end
        if (FadeModule.finish==1) then 
            Complete:drawFull()
            if (playdate.buttonJustPressed("a")) then
                gameState='initTitle'
            end
        end
    end
    --playdate.drawFPS()
end

function playdate.BButtonHeld()
end

function playdate.cranked()
    
end

function playdate.gameWillTerminate()
    Game:saveGameData()
end

function playdate.deviceWillSleep()
    Game:saveGameData()
end

function playdate.gameWillPause()
    Game:saveGameData()
end

function playdate.keyPressed(key)

end

