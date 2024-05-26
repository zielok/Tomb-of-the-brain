import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/frameTimer"

local gfx = playdate.graphics
screenImage = gfx.image.new(400, 240)

class('FadeModule').extends()
function FadeModule:init()
    --self.Image = gfx.image.new('img/white')

end
function FadeModule:setup1()
    gfx.lockFocus(screenImage)
end
function FadeModule:setup2()
    gfx.unlockFocus()
    self.Image2 = screenImage
    self:startFade()
end

function FadeModule:startFade()
    self.fade = 0
    self.finish = 0
    --self.ditherMet = ditherMethod[math.random(1,10)]
end

function FadeModule:updateFade(speed)
    if (self.finish==0) then
        if (self.fade<1) then
            self.fade = self.fade+(1/speed)
        else
            self.finish = 1
        end
        --self.Image2:drawFaded(0,0,self.fade,self.ditherMet)
        --self.Image2:drawScaled(0,0,self.fade)

        self.Image2:scaledImage(self.fade):drawCentered(200,120)

    end
end

--[[
example

gfx.setBackgroundColor(gfx.kColorClear)
Image1:draw(0,0)
if (state==0) then

    FadeModule:setup()
    Image1:draw(0,0)
    FadeModule:setup1()

    FadeModule:setup()
    Image2:draw(0,0)
    FadeModule:setup2()

    FadeModule:startFade()
    if playdate.buttonJustPressed("a") then
        state = 1
    end
elseif (state==1) then
    FadeModule:updateFade(15)
    if (FadeModule.finish==1) then
        state = 2
    end
elseif (state==2) then
    Image2:draw(0,0)
end

]]--