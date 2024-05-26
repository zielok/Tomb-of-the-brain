local gfx = playdate.graphics

class('Over').extends()
function Over:init()
	self.image = gfx.image.new('img/over')
end

function Over:draw()
	
end

function Over:drawFull()
	self.image:draw(0,0)
end