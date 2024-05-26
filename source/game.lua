local gfx = playdate.graphics

local spriteUpdate <const> = playdate.graphics.sprite.update

grafika = gfx.imagetable.new('img/klocki')
player = gfx.imagetable.new('img/player')


class('Game').extends()
function Game:init()
	self.image = gfx.image.new('img/game')
	gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            gfx.setClipRect( x, y, width, height ) -- just draw what we need
            self.image:draw( 0, 0 )
            gfx.clearClipRect()
        end
    )
    
	removeSysMenu()
	sysMenuGame()
	startlevel()
end

function Game:draw()
	
end

function Game:drawFull()
	spriteUpdate()
	animtime()
	--self.image:draw(0,0)
	drawboard() 
	drawja()
	drawboardeffect()
end

function Game:saveGameData()
    local gameData = {
        currentLevel = runda
    }
    playdate.datastore.write(gameData)
end

function Game:undoW()
	if undo>1 then
		undo=undo-1
		levelact[undox[undo]][undoy[undo]]=undov[undo]
		ja.x=undox[undo]
		ja.y=undoy[undo]
	end
end

function Game:undo()
	if playdate.buttonJustPressed("b") then
        Game:undoW()
    end

    local crankTicks = playdate.getCrankTicks(6)

    if crankTicks == 1 then
        Game:undoW()
    elseif crankTicks == -1 then
        Game:undoW()
    end
end

function playMoveSFX()
	local sfmove = math.random(1,4)
	if (sfmove==1) then smove1:play()
	elseif (sfmove==2) then smove2:play()
	elseif (sfmove==3) then smove3:play()
	elseif (sfmove==4) then smove4:play()
	end
end

function playCompleteSFX()
	local sfmove = math.random(1,4)
	if (sfmove==1) then slevelcomplete:play()
	elseif (sfmove==2) then slevelcomplete2:play()
	elseif (sfmove==3) then slevelcomplete3:play()
	elseif (sfmove==4) then slevelcomplete4:play()
	end
end

function Game:update()
	if (jamove==0) then
		if (playdate.buttonIsPressed("left")) then
			if (checkpossible(ja.x-1,ja.y)) then
				if checkpossible2(ja.x,ja.y,2) then
					playMoveSFX()
					jamove=1
					klocekmin(ja.x,ja.y)
				end
			end
		end
		if (playdate.buttonIsPressed("right")) then
			if (checkpossible(ja.x+1,ja.y)) then
				if checkpossible2(ja.x,ja.y,0) then
					playMoveSFX()
					jamove=2
					klocekmin(ja.x,ja.y)
				end
			end
		end
		if (playdate.buttonIsPressed("up")) then
			if (checkpossible(ja.x,ja.y-1)) then
				if checkpossible2(ja.x,ja.y,1) then
					playMoveSFX()
					jamove=3
					klocekmin(ja.x,ja.y)
				end
			end
		end
		if (playdate.buttonIsPressed("down")) then
			if (checkpossible(ja.x,ja.y+1)) then
				if checkpossible2(ja.x,ja.y,3) then
					playMoveSFX()
					jamove=4
					klocekmin(ja.x,ja.y)
				end
			end
		end
	end
	if (jamove==1) then ja.xo=ja.xo-1
	end
	if (jamove==2) then ja.xo=ja.xo+1
	end
	if (jamove==3) then ja.yo=ja.yo-1
	end
	if (jamove==4) then ja.yo=ja.yo+1
	end
	if (jamove>0) then 
		animdelayproc()
		if (ja.xo==16 or ja.yo==16 or ja.xo==-16 or ja.yo==-16) then
			jamove=0
			if (ja.xo==16) then ja.x=ja.x+1
			end
			if (ja.xo==-16) then ja.x=ja.x-1
			end
			if (ja.yo==16) then ja.y=ja.y+1
			end
			if (ja.yo==-16) then ja.y=ja.y-1
			end
			ja.xo=0
			ja.yo=0
		end
	end
	if (jamove==0) then
		checkteleport(ja.x,ja.y)
		if (checkcomplete()==1) then
			playCompleteSFX()
			runda=runda+1
			if (runda<=30) then
				gameState='levelnext'
			else
				runda = 1
				gameState='completeinit'
			end
			Game:saveGameData()
		elseif (checkover(ja.x,ja.y)==false ) then 
			--sfx (4)
			gameState="overinit"
		end
	end
	Game:undo()
end