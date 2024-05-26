local gfx = playdate.graphics

class('Prelevel').extends()
function Prelevel:init()
	self.image = gfx.image.new('img/prelevel')
	self.font = gfx.font.new('img/cyfry/cyfry')
end

function Prelevel:draw()
	
end

function Prelevel:drawFull()
	self.image:draw(0,0)
	gfx.setFont(self.font)
	gfx.drawTextAligned(runda, 200, 70,kTextAlignment.center)
end