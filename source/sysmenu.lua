import "CoreLibs/ui"

local gfx = playdate.graphics

function removeSysMenu()
    local menu = playdate.getSystemMenu()

    menu:removeAllMenuItems()
end

function sysMenuGame()
    local menu = playdate.getSystemMenu()

    local menuItem, error = menu:addMenuItem("Restart", function()
        Game:init()
        gameState='game'
    end)

    local checkmarkMenuItem, error = menu:addMenuItem("Menu", function(value)
        gfx.sprite.removeAll()
        removeSysMenu()
        gameState='initTitle'
    end)
end

function sysMenuTitle()
    local menu = playdate.getSystemMenu()

    local menuItem, error = menu:addMenuItem("Start", function()
        Prelevel:init()
        FadeModule:setup1()
        Prelevel:drawFull()
        FadeModule:setup2()
        gameState='prelevel'
    end)

    local checkmarkMenuItem, error = menu:addMenuItem("Reset save", function(value)
        sreset:play()
        runda = 1
        Game:saveGameData()
    end)
end