-- tunnels
--
-- experiments in stereo delay
-- 
-- page 1: modes
-- page 2: control method
--
-- K1 (hold): clear buffers
-- K2 & K3: randomize (manual)
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
local UI = require "ui"
--local tn = require "lib/tunnel"
local tn = include('lib/tunnel')

local pages
local SCREEN_FRAMERATE = 15
local screen_dirty = true
local current_freq = -1
local last_freq = -1
local tunnelgroup
local tunnelmode = 1
local tunnelmodes_list
local tunnelmodes = {"off", "fractal landscape", "disemboguement", "post-horizon", "coded air", "failing lantern", "blue cat", "crawler"}
local tunnelcontrol = 1
local tunnelcontrols_list
local tunnelcontrols = {"manual", "input frequency", "input amplitude"}


local function tunnels_pan()
  if tunnelgroup == 1 then
    softcut.pan(1, math.random(75, 90) * 0.01)
    softcut.pan(4, math.random(25, 45) * 0.01)
    
  elseif tunnelgroup == 2 then
    softcut.pan(2, math.random(10, 25) * 0.01)
    softcut.pan(3, math.random(55, 75) * 0.01)
  end
end

local function update_tunnels()
  -- set panning
  tunnels_pan()
    
	-- reset filters before changing (some modes don't use)
  for i=1,4 do 
    softcut.level(i, 1)
    softcut.filter_dry(i, 0.5)
	  softcut.filter_lp(i, 0)
	  softcut.filter_bp(i, 1.0)
	  softcut.filter_rq(i, 2.0)
  end
  params:set("filter_fc3", math.random(40, 80))
  params:set("filter_fc4", math.random(80, 150))
  params:set("filter_fc2", math.random(150, 300))
  params:set("filter_fc1", math.random(300, 1000))
	
	-- specific modes
	
	-- off
	if tunnelmode == 1 then
	  for i=1, 4 do
	    softcut.level(i, 0)
	  end

	-- fractal landscape
	elseif tunnelmode == 2 then
	  if tunnelgroup == 1 then
	    for i=1, 2 do
	      params:set("delay_rate"..i, math.random(0, 250) * 0.01)
	      params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.loop_end(i, math.random(50, 500) * 0.01)
    	  softcut.position(i, math.random(0, 10) * 0.1)
    	  params:set("delay_feedback"..i, math.random(10, 90) * 0.01)
    	  params:set("filter_fc"..i, math.random(40, 1500))
  	  end
	  elseif tunnelgroup == 2 then
	    for i=3, 4 do
	      params:set("delay_rate"..i, math.random(0, 250) * 0.01)
	      params:set("fade_time"..i, math.random(0, 6) * 0.1)
  	    softcut.loop_end(i, math.random(50, 500) * 0.01)
    	  softcut.position(i, math.random(0, 10) * 0.1)
    	  params:set("delay_feedback"..i, math.random(10, 90) * 0.01)
    	  params:set("filter_fc"..i, math.random(40, 1500))
  	  end
	  end
  	
  --disemboguement	
  elseif tunnelmode == 3 then
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
  elseif tunnelmode == 4 then
    if tunnelgroup == 1 then
      for i=1, 2 do 
        params:set("delay_rate"..i, math.random(1, 10) * 0.1)
        params:set("fade_time"..i, math.random(50, 100) * 0.01)
        softcut.position(i, math.random(0, 10) * 0.1)
        softcut.loop_end(i, math.random(100, 1000) * 0.01)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.filter_bp(i, math.random(0, 100) * 0.01)
        params:set("filter_fc"..i, math.random(400, 2000))
      end
    elseif tunnelgroup == 2 then
      for i=3, 4 do 
        params:set("delay_rate"..i, math.random(-10, -1) * 0.1)
        params:set("fade_time"..i, math.random(50, 100) * 0.01)
        softcut.position(i, math.random(0, 10) * 0.1)
        softcut.loop_end(i, math.random(100, 1000) * 0.01)
        params:set("delay_feedback"..i, math.random(10, 80) * 0.01)
        softcut.filter_bp(i, math.random(0, 100) * 0.01)
        params:set("filter_fc"..i, math.random(400, 2000))
      end
    end
    
  --coded air
  elseif tunnelmode == 5 then
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
  elseif tunnelmode == 6 then
    if tunnelgroup == 1 then
      for i=1, 2 do
        params:set("delay_rate"..i, math.random(10, 25) * 0.1)
        --softcut.loop_start(i, math.random(0, 50) * 0.01)
        softcut.loop_end(i, math.random(6, 10))
        params:set("delay_feedback"..i, math.random(10, 30) * 0.01)
        params:set("fade_time"..i, math.random(0, 40) * 0.1)
      end
    elseif tunnelgroup == 2 then
      for i=3, 4 do 
        params:set("delay_rate"..i, math.random(10, 25) * 0.1)
        softcut.loop_end(i, math.random(4,6))
        params:set("delay_feedback"..i, math.random(10, 30) * 0.01)
        params:set("fade_time"..i, math.random(0, 40) * 0.1)
      end
    end
    
  -- blue cat
	elseif tunnelmode == 7 then
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
	elseif tunnelmode == 8 then
	  for i=1, 4 do
	    softcut.filter_dry(i, 0.25)
	    softcut.loop_start(i, 0)
	    softcut.position(i, 0)
	  end
	  softcut.loop_end(1, .1)
	  softcut.loop_end(2, .4)
	  softcut.loop_end(3, .2)
	  softcut.loop_end(4, .3)
	  if tunnelgroup == 1 then
	    for i=1, 2 do
  	    params:set("delay_rate"..i, math.random(5, 15) * 0.1)
  	    softcut.fade_time(i, math.random(0, 6) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  elseif tunnelgroup == 2 then
	    for i=3, 4 do
  	    params:set("delay_rate"..i, math.random(5, 15) * 0.1)
  	    softcut.fade_time(i, math.random(0, 6) * 0.1)
  	    params:set("delay_feedback"..i, math.random(0, 100) * 0.01)
  	  end
	  end
  end
end

local function update_freq(freq)
  current_freq = freq
  if tunnelcontrol == 2 then
    
    if current_freq > 0 then last_freq = current_freq end
    if current_freq > 60 and current_freq < 260 then
      print("updating freq 1")
      tunnelgroup = 1
      update_tunnels()
    elseif current_freq > 260 then
      print("updating freq 2")
      tunnelgroup = 2
      update_tunnels()
    end
  end
  screen_dirty = true
end

local function update_vol(cvol)
  local power = 10^2
  current_vol = math.floor(cvol * power) / power
  if tunnelcontrol == 3 then
    if current_vol > 0.01 then 
      print("updating vol")
      tunnelgroup = 1
      update_tunnels()
      tunnelgroup = 2
      update_tunnels()
    end
  end
  screen_dirty = true
end

-- Encoder input
function enc(n, delta)
  
  if n == 1 then
    -- Page scroll
    pages:set_index_delta(util.clamp(delta, -1, 1), false)
  end
  
  if pages.index == 1 then
    if n == 2 then
      tunnelmodes_list:set_index_delta(util.clamp(delta, -1, 1))
      tunnelmode = tunnelmodes_list.index
      softcut.buffer_clear()
      tunnelgroup = 1
      update_tunnels()
      tunnelgroup = 2
      update_tunnels()
    end
  elseif pages.index == 2 then
    if n == 2 then
      tunnelcontrols_list:set_index_delta(util.clamp(delta, -1, 1))
      tunnelcontrol = tunnelcontrols_list.index
    end
    
  end
  
  screen_dirty = true
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
  pages = UI.Pages.new(1, 2)
  tunnelmodes_list = UI.ScrollingList.new(8, 8, 1, tunnelmodes)
  tunnelcontrols_list = UI.ScrollingList.new(8, 8, 1, tunnelcontrols)
  
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
  
  -- Start drawing to screen
  screen_refresh_metro = metro.init()
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
	screen.move(88,10)
	screen.text("tunnels")
  pages:redraw()
  if pages.index == 1 then
    tunnelmodes_list:redraw()
  elseif pages.index == 2 then
    tunnelcontrols_list:redraw()
  end
	screen.update()
end
