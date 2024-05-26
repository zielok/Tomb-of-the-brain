local gfx = playdate.graphics
local spriteUpdate <const> = playdate.graphics.sprite.update

class('TitleScreen').extends()
function TitleScreen:init()
    self.image = gfx.image.new('img/title')
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            gfx.setClipRect( x, y, width, height ) -- just draw what we need
            self.image:draw( 0, 0 )
            gfx.clearClipRect()
        end
    )
    self.logo = gfx.image.new('img/logo')
    self.play = gfx.image.new('img/playbutton')
    self.reset = gfx.image.new('img/reset')
    self.timeline = 0
    self.fade = 0
    self.fade2 = 0
    self.state = "fade"
	removeSysMenu()
    sysMenuTitle()
end

function TitleScreen:draw()
	if (self.state=='fade') then
		self.timeline = 1 + self.timeline
		if (self.fade<1) then
			self.fade = self.fade + 1/30
		else
			self.fade = 1
		end
		if (self.timeline>28) then
			if (self.fade2<1) then
				self.fade2 = self.fade2 + 1/15
			else
				self.fade2 = 1
				self.state = "show"
			end
		end
	    self.image:drawFaded(0,0,self.fade*3,gfx.image.kDitherTypeScreen)
	    self.logo:drawFaded(10,150,self.fade,gfx.image.kDitherTypeFloydSteinberg)
	    self.play:drawFaded(400-176,30,self.fade2,gfx.image.kDitherTypeVerticalLine)
	    if (runda>1) then self.reset:drawFaded(400-157,240-21,self.fade2,gfx.image.kDitherTypeVerticalLine) end
	elseif (self.state=='show') then
		--self:drawFull()
	end
end

function TitleScreen:drawFull()
	--self.image:draw(0,0)
	spriteUpdate()
	self.logo:draw(10,150)
	self.play:draw(400-176,30)
	if (runda>1) then self.reset:draw(400-157,240-21) end
end