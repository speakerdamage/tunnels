-- tunnels (base script)
--
-- experiments in stereo delay
-- 
-- K1 hold: change mode
-- K2 & K3: change params
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

local function tunnels_pan(v)
  if v == a then
    softcut.pan(1, math.random(75, 100) * .01)
    softcut.pan(3, math.random(55, 75) * .01)
  else
    softcut.pan(2, math.random(0, 25) * .01)
    softcut.pan(4, math.random(25, 45) * .01)
  end
end

local function udpate_tunnels(voice)
  for i=1,4 do 
    softcut.filter_dry(i, 0.125);
	  softcut.filter_fc(i, 1200);
	  softcut.filter_lp(i, 0);
	  softcut.filter_bp(i, 1.0);
	  softcut.filter_rq(i, 2.0);
  end
  softcut.level(5,0.0)
  softcut.level(6,0.0)
  softcut.level_input_cut(5, 5, 0.0)
	softcut.level_input_cut(6, 6, 0.0)
	softcut.rec_level(5, 0)
	softcut.rec_level(6, 0)
	softcut.play(5, 0)
	softcut.play(6, 0)

	-- highway
	if tunnelmode == 1 then
  	if voice == 1 or voice == 3 then
  	  tunnels_pan(a)
  	  softcut.fade_time(1, math.random(0, 6) * .1)
  	  softcut.fade_time(3, math.random(0, 6) * .1)
  	  softcut.rate(1, math.random(0, 80) * .1)
  	  softcut.position(1, math.random(0, 10) * .1)
  	  softcut.pre_level(1, math.random(0, 100) * .01)
  	  softcut.rate(3, math.random(0, 80) * .1)
  	  softcut.position(3, math.random(0, 10) * .1)
  	  softcut.pre_level(3, math.random(0, 100) * .01)
  	  softcut.filter_fc(1, math.random(800, 2000));
  	  softcut.filter_fc(3, math.random(800, 2000));
  	else 
  	  tunnels_pan(b)
  	  softcut.fade_time(2, math.random(0, 6) * .1)
  	  softcut.fade_time(4, math.random(0, 6) * .1)
  	  softcut.rate(2, math.random(0, 80) * .1)
  	  softcut.position(2, math.random(0, 10) * .1)
  	  softcut.pre_level(2, math.random(0, 100) * .01)
  	  softcut.rate(4, math.random(0, 80) * .1)
  	  softcut.position(4, math.random(0, 10) * .1)
  	  softcut.pre_level(4, math.random(0, 100) * .01)
  	  softcut.filter_fc(2, math.random(800, 2000));
  	  softcut.filter_fc(4, math.random(800, 2000));
  	end
  	
  --disemboguement	
  elseif tunnelmode == 2 then
    if voice == 1 or voice == 3 then
      tunnels_pan(a)
      softcut.fade_time(1, math.random(0, 20) * .1)
  	  softcut.fade_time(3, math.random(0, 20) * .1)
      softcut.position(1, math.random(0, 10) * .1)
      softcut.position(3, math.random(0, 10) * .1)
      softcut.loop_end(1, math.random(5, 30) * .01)
      softcut.loop_end(3, math.random(30, 50) * .01)
      softcut.rate(1, math.random(1, 10) * 0.1)
      softcut.rate(3, math.random(-10, -1) * 0.1)
      softcut.pre_level(voice, math.random(10, 80) * 0.01)
      softcut.filter_fc(1, math.random(400, 5000))
      softcut.filter_fc(3, math.random(400, 5000))
    else
      tunnels_pan(b)
      softcut.fade_time(2, math.random(0, 20) * .1)
  	  softcut.fade_time(4, math.random(0, 20) * .1)
      softcut.position(2, math.random(0, 10) * .1)
      softcut.position(4, math.random(0, 10) * .1)
      softcut.loop_end(2, math.random(5, 30) * .01)
      softcut.loop_end(4, math.random(30, 50) * .01)
      softcut.rate(2, math.random(1, 10) * 0.1)
      softcut.rate(4, math.random(-10, -1) * 0.1)
      softcut.pre_level(2, math.random(0, 100) * .01)
      softcut.pre_level(4, math.random(0, 100) * .01)
      softcut.filter_fc(2, math.random(400, 5000))
      softcut.filter_fc(4, math.random(400, 5000))
    end
  
   --post-horizon
  elseif tunnelmode == 3 then
    softcut.rate(1, 1)
    softcut.rate(3, -1)
    softcut.rate(2, 1)
    softcut.rate(4, -1)
    if voice == 1 or voice == 3 then
      tunnels_pan(a)
      softcut.fade_time(1, math.random(50, 100) * .01)
      softcut.fade_time(3, math.random(50, 100) * .01)
      softcut.position(1, math.random(0, 10) * .1)
      softcut.position(3, math.random(0, 10) * .1)
      softcut.loop_end(1, math.random(50, 100) * .01)
      softcut.loop_end(3, math.random(50, 100) * .01)
      softcut.pre_level(voice, math.random(10, 80) * 0.01)
      softcut.filter_bp(1, math.random(0, 100) * 0.01)
      softcut.filter_bp(3, math.random(0, 100) * 0.01)
      softcut.filter_fc(1, math.random(400, 5000))
      softcut.filter_fc(3, math.random(400, 5000))
    else
      tunnels_pan(b)
      softcut.fade_time(2, math.random(50, 100) * .01)
      softcut.fade_time(4, math.random(50, 100) * .01)
      softcut.position(2, math.random(0, 10) * .1)
      softcut.position(4, math.random(0, 10) * .1)
      softcut.loop_end(2, math.random(50, 100) * .01)
      softcut.loop_end(4, math.random(50, 100) * .01)
      softcut.pre_level(voice, math.random(10, 80) * 0.01)
      softcut.filter_bp(2, math.random(0, 100) * 0.01)
      softcut.filter_bp(4, math.random(0, 100) * 0.01)
      softcut.filter_fc(2, math.random(400, 5000))
      softcut.filter_fc(4, math.random(400, 5000))
    end
    
  --coded air
  elseif tunnelmode == 4 then
    if voice == 1 or voice == 3 then
      tunnels_pan(a)
      softcut.rate(1, math.random(-100, 0) * .02)
      softcut.rate(3, math.random(-100, 0) * .02)
      softcut.loop_end(1, math.random(10, 500) * .01)
      softcut.loop_end(3, math.random(10, 500) * .01)
	    softcut.pre_level(1, math.random(50, 75) * .01)
	    softcut.pre_level(3, math.random(0, 50) * .01)
    else
      tunnels_pan(b)
      softcut.rate(2, math.random(-100, 0) * .02)
      softcut.rate(4, math.random(-100, 0) * .02)
      softcut.loop_end(1, math.random(10, 500) * .01)
      softcut.loop_end(3, math.random(10, 500) * .01)
	    softcut.pre_level(2, math.random(50, 75) * .01)
	    softcut.pre_level(4, math.random(0, 50) * .01)
    end

  --failing lantern
  elseif tunnelmode == 5 then
    if voice == 1 or voice == 3 then
      tunnels_pan(a)
      softcut.rate(1, -8)
      softcut.rate(3, math.random(0, 80) * .1)
      softcut.loop_start(1, math.random(0, 50) * .01)
      softcut.loop_end(1, 4)
      softcut.loop_end(3, 2)
	    softcut.pre_level(1, math.random(70, 99) * .01)
	    softcut.pre_level(3, math.random(0, 50) * .01)
    else
      tunnels_pan(b)
      softcut.rate(2, -8)
      softcut.rate(4, math.random(0, 80) * .1)
      softcut.loop_start(2, math.random(0, 50) * .01)
      softcut.loop_end(2, 4)
      softcut.loop_end(4, 2)
	    softcut.pre_level(2, math.random(70, 99) * .01)
	    softcut.pre_level(4, math.random(0, 50) * .01)
    end
    
  -- blue cat
	elseif tunnelmode == 6 then
	  -- 6 voices
	  softcut.level(5,1.0)
    softcut.level(6,1.0)
    softcut.level_input_cut(5, 5, 1.0)
  	softcut.level_input_cut(6, 6, 1.0)
  	softcut.rec_level(5, 1)
  	softcut.rec_level(6, 1)
  	softcut.play(5, 1)
  	softcut.play(6, 1)
  	if voice == 1 or voice == 3 then
  	  tunnels_pan(a)
  	  softcut.fade_time(1, math.random(0, 6) * .1)
  	  softcut.fade_time(3, math.random(0, 6) * .1)
  	  softcut.rate(1, math.random(0, 80) * .1)
  	  softcut.position(1, math.random(0, 10) * .1)
  	  softcut.pre_level(1, math.random(0, 100) * .01)
  	  softcut.rate(3, math.random(0, 80) * .1)
  	  softcut.position(3, math.random(0, 10) * .1)
  	  softcut.pre_level(3, math.random(0, 100) * .01)
  	else 
  	  tunnels_pan(b)
  	  softcut.fade_time(2, math.random(0, 6) * .1)
  	  softcut.fade_time(4, math.random(0, 6) * .1)
  	  softcut.rate(2, math.random(0, 80) * .1)
  	  softcut.position(2, math.random(0, 10) * .1)
  	  softcut.pre_level(2, math.random(0, 100) * .01)
  	  softcut.rate(4, math.random(0, 80) * .1)
  	  softcut.position(4, math.random(0, 10) * .1)
  	  softcut.pre_level(4, math.random(0, 100) * .01)
  	end
  end
end

function enc(n, d)
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
      tunnelmode = 6
    elseif tunnelmode == 6 then
      tunnelmode = 1
    end
    
    for i=1,4 do
      udpate_tunnels(i)
    end
    redraw()
  end
end

-- Key input
function key(n, z)
  if z == 1 then
    if n == 1 then
      softcut.buffer_clear()
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
  elseif tunnelmode == 6 then
    printmode = "blue cat"
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
