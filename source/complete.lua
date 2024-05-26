local gfx = playdate.graphics

class('Complete').extends()
function Complete:init()
	self.image = gfx.image.new('img/complete')
end

function Complete:draw()
	
end

function Complete:drawFull()
	self.image:draw(0,0)
end