import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/frameTimer"
import "CoreLibs/ui"
import "CoreLibs/easing"
import "CoreLibs/crank"

import 'sprite.lua'
import 'sysmenu.lua'
import 'fadeModule.lua'
import 'title.lua'
import 'prelevel.lua'
import 'game.lua'
import 'over.lua'
import 'complete.lua'
import 'pico8.lua'
import 'sfx.lua'

local gfx = playdate.graphics
local sfx = playdate.sound.sampleplayer
local msx = playdate.sound.fileplayer


ditherMethod = {gfx.image.kDitherTypeDiagonalLine,gfx.image.kDitherTypeVerticalLine,gfx.image.kDitherTypeHorizontalLine,
        gfx.image.kDitherTypeScreen,gfx.image.kDitherTypeBayer2x2,gfx.image.kDitherTypeBayer4x4,gfx.image.kDitherTypeBayer8x8,
        gfx.image.kDitherTypeFloydSteinberg,gfx.image.kDitherTypeBurkes,gfx.image.kDitherTypeAtkinson}


gameState = 'initTitle'

--[[
In the game whose objective is to remove all tiles, players will face the challenge of overcoming various obstacles and solving difficult puzzles. These tiles not only differ in appearance but also in their method of interaction, adding a strategic element to the game.

In the game world, you will encounter various types of tiles. Some of them require multiple presses to be removed, adding a layer of difficulty and decision-making. Other tiles allow movement only in specific directions, requiring players to carefully plan their moves to avoid getting stuck in a trap. There are also tiles that teleport the player to another location on the board, adding a dynamic aspect to the gameplay.

To meet this challenge, players have intuitive controls at their disposal. The D-pad enables smooth movement across the board, which is crucial for success in tile removal. Additionally, the crank or button B allows players to undo their last move, which is useful in case of mistakes or the need to rethink a strategy.

The game fully engages players, demanding not only reflexes but also planning and problem-solving skills. Each level presents new challenges, and the diversity of tiles keeps the gameplay fresh and full of surprises. Will you be able to conquer all levels and clear all the tiles?

Controls:
D-pad - movement
Crank or B - undo last move
]]--

--[[
help

Paint image table
ImagesTab = playdate.graphics.imagetable.new(images)
ImagesTab:drawImage(im,x,y)

load image
Image1 = gfx.image.new('img/1.png')

draw background
self.image = gfx.image.new('img/game')
        gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            gfx.setClipRect( x, y, width, height ) -- just draw what we need
            self.image:draw( 0, 0 )
            gfx.clearClipRect()
        end
    )

]]--