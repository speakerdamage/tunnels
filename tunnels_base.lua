-- tunnels (base script)
--
-- experiments in stereo delay
-- 
-- K1 change mode
-- K2 left lane
-- K3 right lane
--
-- "I see atonal fluxes of known 
-- forms mirrored in the 
-- repititious composition of 
-- the terrain."
-- - Ed Steck, An Interface 
-- for a Fractal Landscape
--
-- v1.0 @speakerdamage


engine.name = "TestSine"

--local tn = require "smalltalk/lib/tunnels"
local tn = dofile('/home/we/dust/code/tunnels/lib/tunnel.lua')



local screen_dirty = true
local tunnelmode = 1
local printmode = "highway"





local function udpate_tunnels(voice)
	--softcut.rate(voice, math.random(-800, 800) * .01)
	softcut.fade_time(voice, math.random(0, 6) * .1)
	if voice == 1 or voice == 3 then
	    softcut.pan(1, 1)
	    softcut.pan(3, math.random(1, 5) * .1)
	    softcut.rate(voice, math.random(0, 80) * .1)
	    softcut.position(voice, 1)
	  if tunnelmode == 1 then
	    softcut.play(3, 0)
	    softcut.rec(3, 0)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(1, 0.70)
	  elseif tunnelmode == 2 then
	    softcut.play(3, 1)
	    softcut.rec(3, 1)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(1, 0.70)
	    softcut.pre_level(3, 0.70)
	  elseif tunnelmode == 3 then
	    softcut.play(3, 1)
	    softcut.rec(3, 1)
	    softcut.loop_end(voice, 1)
	    softcut.pre_level(1, math.random(0, 100) * .01)
	    softcut.pre_level(3, math.random(0, 100) * .01)
	  elseif tunnelmode == 4 then
	    softcut.play(3, 1)
	    softcut.rec(3, 1)
	    softcut.rate(1, 1)
	    softcut.rate(3, 0)
	    softcut.position(3, 0)
	  end
	  
	else 
	  softcut.position(voice, math.random(0, 10) * .1)
	  softcut.pan(2, 0)
	  softcut.pan(4, math.random(5, 10) * .1)
	  softcut.rate(voice, math.random(-80, 0) * .1)
	  if tunnelmode == 1 then
	    softcut.play(4, 0)
	    softcut.rec(4, 0)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(2, 0.70)
	  elseif tunnelmode == 2 then
	    softcut.play(4, 1)
	    softcut.rec(4, 1)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(2, 0.70)
	    softcut.pre_level(4, 0.70)
	  elseif tunnelmode == 3 then
	    softcut.play(4, 1)
	    softcut.rec(4, 1)
	    softcut.loop_end(voice, 1)
	    softcut.pre_level(2, math.random(0, 100) * .01)
	    softcut.pre_level(4, math.random(0, 100) * .01)
	  elseif tunnelmode == 4 then
	    softcut.play(4, 1)
	    softcut.rec(4, 1)
	    softcut.rate(2, 1)
	    softcut.rate(4, 0)
	    softcut.position(4, 0)
	  end
	end
end

-- Key input
function key(n, z)
  if z == 1 then
    if n == 1 then
      if tunnelmode == 1 then
        tunnelmode = 2
      elseif tunnelmode == 2 then
        tunnelmode = 3
      elseif tunnelmode == 3 then
        tunnelmode = 4
      elseif tunnelmode == 4 then
        tunnelmode = 1
      end
      udpate_tunnels(1)
      udpate_tunnels(2)
      udpate_tunnels(3)
      udpate_tunnels(4)
      redraw()
    elseif n == 2 then
      udpate_tunnels(1)
      udpate_tunnels(3)
      redraw()
    elseif n == 3 then
      udpate_tunnels(2)
      udpate_tunnels(4)
      redraw()
    end
  end
end


function init()
  engine.amp(0)
  params:bang()
  screen.aa(1)
  tn.init()
end

function redraw()
  screen.clear()
  if tunnelmode == 1 then
    printmode = "highway"
  elseif tunnelmode == 2 then
    printmode = "disemboguement"
  elseif tunnelmode == 3 then
    printmode = "meander"
  elseif tunnelmode == 4 then
    printmode = "fractal landscape"
  end
  screen.move(0,0)
	
  screen.font_size(12)
	screen.move(10,18)
	
	screen.text("tunnels")
	screen.move(10,56)
	screen.font_size(8)
	screen.text(printmode)
	screen.move(0,0)
	--screen.display_png("/home/we/dust/code/smalltalk/tunnel.png", 0, 0)

	screen.update()
	
end
