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

local ControlSpec = require "controlspec"
local MusicUtil = require "musicutil"
local Formatters = require "formatters"

--local tn = require "smalltalk/lib/tunnels"
local tn = dofile('/home/we/dust/code/tunnels/lib/tunnel.lua')

local SCREEN_FRAMERATE = 15
local screen_dirty = true
local tunnelmode = 0
local printmode = "tunnels off"
local tunnelgroup
local current_freq = -1
local last_freq = -1

local function tunnels_pan()
  if tunnelgroup == 1 then
    softcut.pan(1, math.random(75, 90) * 0.01)
    softcut.pan(2, math.random(10, 25) * 0.01)
  elseif tunnelgroup == 2 then
    softcut.pan(3, math.random(55, 75) * 0.01)
    softcut.pan(4, math.random(25, 45) * 0.01)
  end
end

local function update_tunnels()
  -- set panning
  tunnels_pan()
    
	-- reset filters before changing (as some modes don't use)
  for i=1,4 do 
    softcut.level(i, 1)
    softcut.filter_dry(i, 0.5)
    params:set("filter_fc"..i, math.random(800, 1400))
	  softcut.filter_lp(i, 0)
	  softcut.filter_bp(i, 1.0)
	  softcut.filter_rq(i, 2.0)
  end
	
	-- specific modes
	
	-- delay off
	if tunnelmode == 0 then
	  for i=1, 4 do
	    softcut.level(i, 0)
	  end

	-- fractal landscape
	elseif tunnelmode == 1 then
	  if tunnelgroup == 1 then
	    for i=1, 2 do
	      params:set("delay_rate"..i, math.random(0, 250) * 0.01)
	      params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.loop_end(i, math.random(50, 500) * 0.01)
    	  softcut.position(i, math.random(0, 10) * 0.1)
    	  params:set("delay_feedback"..i, math.random(10, 90) * 0.01)
    	  params:set("filter_fc"..i, math.random(40, 1000))
  	  end
	  elseif tunnelgroup == 2 then
	    for i=3, 4 do
	      params:set("delay_rate"..i, math.random(0, 250) * 0.01)
	      params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.loop_end(i, math.random(50, 500) * 0.01)
    	  softcut.position(i, math.random(0, 10) * 0.1)
    	  params:set("delay_feedback"..i, math.random(10, 90) * 0.01)
    	  params:set("filter_fc"..i, math.random(40, 1000))
  	  end
	  end
  	
  --disemboguement	
  elseif tunnelmode == 2 then
    if tunnelgroup == 1 then
      params:set("filter_fc1", math.random(40, 400))
      params:set("filter_fc2", math.random(400, 800))
      for i=1, 2 do 
        params:set("delay_rate"..i, math.random(1, 10) * 0.1)
        params:set("fade_time"..i, math.random(0, 20) * 0.1)
        softcut.position(i, math.random(0, 10) * 0.1)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.loop_end(i, math.random(5, 30) * 0.01)
      end
    elseif tunnelgroup == 2 then
      params:set("filter_fc3", math.random(40, 400))
      params:set("filter_fc4", math.random(400, 800))
      for i=3, 4 do 
        params:set("delay_rate"..i, math.random(-10, -1) * 0.1)
        params:set("fade_time"..i, math.random(0, 20) * 0.1)
        softcut.position(i, math.random(0, 10) * 0.1)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.loop_end(i, math.random(30, 50) * 0.01)
      end
    end
  
   --post-horizon
  elseif tunnelmode == 3 then
    if tunnelgroup == 1 then
      for i=1, 2 do 
        params:set("delay_rate"..i, math.random(1, 10) * 0.1)
        params:set("fade_time"..i, math.random(50, 100) * 0.01)
        softcut.position(i, math.random(0, 10) * 0.1)
        softcut.loop_end(i, math.random(100, 1000) * 0.01)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.filter_bp(i, math.random(0, 100) * 0.01)
        params:set("filter_fc"..i, math.random(400, 5000))
      end
    elseif tunnelgroup == 2 then
      for i=3, 4 do 
        params:set("delay_rate"..i, math.random(-10, -1) * 0.1)
        params:set("fade_time"..i, math.random(50, 100) * 0.01)
        softcut.position(i, math.random(0, 10) * 0.1)
        softcut.loop_end(i, math.random(100, 1000) * 0.01)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.filter_bp(i, math.random(0, 100) * 0.01)
        params:set("filter_fc"..i, math.random(400, 5000))
      end
    end
    
  --coded air
  elseif tunnelmode == 4 then
    if tunnelgroup == 1 then
      for i=1, 2 do 
        params:set("delay_feedback"..i, math.random(50, 75) * 0.01)
        params:set("delay_rate"..i, math.random(-100, 0) * 0.02)
        softcut.loop_end(i, math.random(10, 500) * .01)
      end
    elseif tunnelgroup == 2 then
      for i=3, 4 do 
        params:set("delay_feedback"..i, math.random(0, 50) * 0.01)
        params:set("delay_rate"..i, math.random(-100, 0) * 0.02)
        softcut.loop_end(i, math.random(10, 500) * .01)
      end
    end
    
  --failing lantern
  elseif tunnelmode == 5 then
    if tunnelgroup == 1 then
      for i=1, 2 do
        params:set("delay_rate"..i, -8)
        softcut.loop_start(i, math.random(0, 50) * 0.01)
        softcut.loop_end(i, math.random(4, 10))
        params:set("delay_feedback"..i, math.random(70, 99) * 0.01)
      end
    elseif tunnelgroup == 2 then
      for i=3, 4 do 
        params:set("delay_rate"..i, math.random(0, 80) * 0.1)
        softcut.loop_end(i, math.random(1,4))
        params:set("delay_feedback"..i, math.random(0, 50) * 0.01)
      end
    end
    
  -- blue cat
	elseif tunnelmode == 6 then
	  if tunnelgroup == 1 then
	    for i=1, 2 do
	      params:set("delay_rate"..i, math.random(0, 80) * 0.1)
  	    params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.position(i, math.random(0, 10) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  elseif tunnelgroup == 2 then
	    for i=3, 4 do
  	    params:set("delay_rate"..i, math.random(0, 80) * 0.1)
  	    params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.position(i, math.random(0, 10) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  end
	  
  -- crawler
	elseif tunnelmode == 7 then
	  for i=1, 4 do
	    softcut.filter_dry(i, 0.25)
	    softcut.loop_start(i, 0)
	    softcut.position(i, 0)
	  end
	  if tunnelgroup == 1 then
	    for i=1, 2 do
  	    params:set("delay_rate"..i, math.random(0, 80) * 0.1)
  	    softcut.loop_end(i, math.random(10, 50) * 0.01)
  	    softcut.fade_time(i, math.random(0, 6) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  elseif tunnelgroup == 2 then
	    for i=3, 4 do
  	    params:set("delay_rate"..i, math.random(0, 80) * 0.1)
  	    softcut.loop_end(i, math.random(10, 50) * 0.01)
  	    softcut.fade_time(i, math.random(0, 6) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  end
  end
end

local function update_freq(freq)
  current_freq = freq
  if current_freq > 0 then last_freq = current_freq end
  if tunnelmode == 1 then
    if current_freq > 200 and current_freq < 350 then 
      tunnelgroup = 1
      update_tunnels()
    elseif current_freq > 350 then
      tunnelgroup = 2
      update_tunnels()
    end
  end
  screen_dirty = true
end

local function update_vol(cvol)
  local power = 10^2
  current_vol = math.floor(cvol * power) / power
  screen_dirty = true
end

function enc(n, d)
  if n == 1 then
    if tunnelmode == 0 then
        tunnelmode = 1
    elseif tunnelmode == 1 then
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
      tunnelmode = 7
    elseif tunnelmode == 7 then
      tunnelmode = 0
    end
    softcut.buffer_clear()
    tunnelgroup = 1
    update_tunnels()
    tunnelgroup = 2
    update_tunnels()
    redraw()
  end
end

-- Key input
function key(n, z)
  if z == 1 then
    if n == 1 then
      softcut.buffer_clear()
    elseif n == 2 then
      tunnelgroup = 1
      update_tunnels()
      redraw()
    elseif n == 3 then
      tunnelgroup = 2
      update_tunnels()
      redraw()
    end
  end
end


function init()
  engine.amp(0)
  
  params:add{type = "option", id = "in_channel", name = "In Channel", options = {"Left", "Right"}}
  params:add{type = "option", id = "note", name = "Note", options = MusicUtil.NOTE_NAMES, default = 10, action = function(value)
    engine.hz(MusicUtil.note_num_to_freq(59 + value))
    screen_dirty = true
  end}
  params:add{type = "control", id = "note_vol", name = "Note Volume", controlspec = ControlSpec.UNIPOLAR, action = function(value)
    engine.amp(value)
    screen_dirty = true
  end}
  
  params:bang()
  
  -- Polls
  
  local pitch_poll_l = poll.set("pitch_in_l", function(value)
    if params:get("in_channel") == 1 then
      update_freq(value)
    end
  end)
  pitch_poll_l:start()
  
  local pitch_poll_r = poll.set("pitch_in_r", function(value)
    if params:get("in_channel") == 2 then
      update_freq(value)
    end
  end)
  pitch_poll_r:start()
  
  local pitch_amp_l = poll.set("amp_in_l", function(value)
    if params:get("in_channel") == 1 then
      update_vol(value)
    end
  end)
  pitch_amp_l:start()
  
  local screen_refresh_metro = metro.init()
  screen_refresh_metro.event = function()
    if screen_dirty then
      screen_dirty = false
      redraw()
    end
  end
  
  screen_refresh_metro:start(1 / SCREEN_FRAMERATE)
  screen.aa(1)
  tn.init()
end

function redraw()
  screen.clear()
  
  local note_num = MusicUtil.freq_to_note_num(last_freq)
  local freq_x
  
  

  if last_freq > 0 then
    screen.move(80, 19)
    screen.text(Formatters.format_freq_raw(last_freq))
  end
  
  if tunnelmode == 0 then
    printmode = "tunnels off"
  elseif tunnelmode == 1 then
    printmode = "fractal landscape"
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
  elseif tunnelmode == 7 then
    printmode = "crawler"
  end
  screen.move(0,0)
	
  screen.font_size(12)
	screen.move(10,18)
	
	screen.text("tunnels")
	screen.move(10,36)
	screen.font_size(8)
	screen.text(printmode)
	screen.move(10,56)
	screen.text(params:get("delay_rate1"))
	screen.move(35,56)
  screen.text(params:get("delay_rate2"))
  screen.move(60,56)
  screen.text(params:get("delay_rate3"))
  screen.move(85,56)
  screen.text(params:get("delay_rate4"))
	screen.update()
	
end
