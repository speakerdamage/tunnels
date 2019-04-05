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
  -- identical fades
  softcut.pan(1, math.random(50, 100) * .01)
  softcut.pan(3, math.random(50, 100) * .01)
  softcut.pan(2, math.random(1, 50) * .01)
  softcut.pan(4, math.random(1, 50) * .01)
	
	-- highway
	if tunnelmode == 1 then
  	if voice == 1 or voice == 3 then
  	  softcut.fade_time(1, math.random(0, 6) * .1)
  	  softcut.fade_time(3, math.random(0, 6) * .1)
  	  softcut.rate(1, math.random(0, 80) * .1)
  	  softcut.position(1, math.random(0, 10) * .1)
  	  softcut.pre_level(1, math.random(0, 100) * .01)
  	  softcut.rate(3, math.random(0, 80) * .1)
  	  softcut.position(3, math.random(0, 10) * .1)
  	  softcut.pre_level(3, math.random(0, 100) * .01)
  	else 
  	  softcut.fade_time(2, math.random(0, 6) * .1)
  	  softcut.fade_time(4, math.random(0, 6) * .1)
  	  softcut.rate(2, math.random(0, 80) * .1)
  	  softcut.position(2, math.random(0, 10) * .1)
  	  softcut.pre_level(2, math.random(0, 100) * .01)
  	  softcut.rate(4, math.random(0, 80) * .1)
  	  softcut.position(4, math.random(0, 10) * .1)
  	  softcut.pre_level(4, math.random(0, 100) * .01)
  	end
  	
  --disemboguement	
  elseif tunnelmode == 2 then
    if voice == 1 or voice == 3 then
      softcut.fade_time(1, .5)
      softcut.fade_time(3, .6)
      softcut.position(voice, 1)
      softcut.loop_end(1, math.random(5, 10) * .01)
      softcut.loop_end(3, math.random(10, 20) * .01)
      softcut.rate(1, 1)
      softcut.rate(3, -1)
      softcut.pre_level(voice, math.random(10, 80) * 0.01)
      softcut.filter_fc(1, math.random(10, 12000))
      softcut.filter_fc(3, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(1, math.random(10, 75) * .1)
      softcut.filter_rq(3, math.random(10, 75) * .1)
    else
      softcut.fade_time(2, .7)
      softcut.fade_time(4, .8)
      softcut.position(voice, 1)
      softcut.loop_end(2, math.random(5, 10) * .01)
      softcut.loop_end(4, math.random(10, 20) * .01)
      softcut.rate(2, 1)
      softcut.rate(4, -1)
      softcut.pre_level(voice, math.random(10, 80) * 0.01)
      softcut.filter_fc(2, math.random(10, 12000))
      softcut.filter_fc(4, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(2, math.random(10, 75) * .1)
      softcut.filter_rq(4, math.random(10, 75) * .1)
    end
  end
	
end

local function udpate_tunnelsssssssssss(voice)
	--reset_tunnels()
	--softcut.buffer_clear()
	--softcut.fade_time(voice, math.random(0, 60) * .01)
	
	if tunnelmode == 5 then
	  -- failing lantern
	  softcut.rate(1, .1)
	  softcut.rate(2, .2)
	  softcut.rate(3, .3)
	  softcut.rate(4, 1)
	  softcut.level(5,1.0)
    softcut.level(6,1.0)
    softcut.level_input_cut(5, 5, 1.0)
	  softcut.level_input_cut(6, 6, 1.0)
	end
	
	if voice == 1 or voice == 3 then
	    softcut.pan(1, -1)
	    --softcut.pan(1, math.random(50, 100) * .01)
	    softcut.pan(3, math.random(1, 50) * .01)
	    --softcut.rate(voice, math.random(0, 80) * .1)
	    --softcut.position(voice, math.random(0, 100) * .01)
	    
	  if tunnelmode == 1 then
	    -- highway (left)
	    softcut.play(3, 0)
	    --softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.fade_time(1, math.random(0, 60) * .01)
	    softcut.pre_level(1, 0.2)
	    
	  elseif tunnelmode == 2 then
	    -- disemboguement (left)
	    softcut.play(3, 1)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(1, 0.70)
	    softcut.pre_level(3, 0.70)
	    
	  elseif tunnelmode == 3 then
	    -- post-horizon (left)
	    softcut.play(3, 1)
	    softcut.loop_end(voice, 1)
	    softcut.pre_level(1, math.random(0, 100) * .01)
	    softcut.pre_level(3, math.random(0, 100) * .01)
	    
	  elseif tunnelmode == 4 then
	    -- coded air (left)
	    softcut.play(3, 1)
	    softcut.rate(1, 1)
	    softcut.rate(3, 0)
	    softcut.position(3, 0)
	  end
	  
	else 
	  -- (right reset)
	  --softcut.position(voice, math.random(0, 10) * .1)
	  softcut.pan(2, 1)
	  --softcut.pan(2, math.random(0, 50) * .01)
	  softcut.pan(4, math.random(5, 10) * .1)
	  --softcut.rate(voice, math.random(-800, 0) * .01)
	  
	  if tunnelmode == 1 then
	    -- highway (right)
	    softcut.play(4, 0)
	    --softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(2, .2)
	    softcut.fade_time(1, math.random(0, 60) * .01)
	    
	  elseif tunnelmode == 2 then
	    -- disemboguement (right)
	    softcut.play(4, 1)
	    softcut.loop_end(voice, math.random(0, 100) * .1)
	    softcut.pre_level(2, 0.70)
	    softcut.pre_level(4, 0.70)
	    
	  elseif tunnelmode == 3 then
	    -- post-horizon (right)
	    softcut.play(4, 1)
	    softcut.loop_end(voice, 1)
	    softcut.pre_level(2, math.random(0, 100) * .01)
	    softcut.pre_level(4, math.random(0, 100) * .01)
	    
	  elseif tunnelmode == 4 then
	    -- coded air (right)
	    softcut.play(4, 1)
	    softcut.rate(2, 1)
	    softcut.position(2, 0.5)
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
        tunnelmode = 5
      elseif tunnelmode == 5 then
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
    printmode = "post-horizon"
  elseif tunnelmode == 4 then
    printmode = "coded air"
  elseif tunnelmode == 5 then
    printmode = "failing lantern"
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
