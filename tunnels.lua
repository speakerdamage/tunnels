-- tunnels
-- v1.2 @speakerdamage
-- experiments in stereo delay
-- https://llllllll.co/t/21973
-- ---------------------
-- 
-- page 2: modes
-- page 3: control method
-- page 4: inputs
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
--
-- please add and share 
-- new modes
-- updated 11.14.2019

engine.name = "TestSine"

local ControlSpec = require "controlspec"
local MusicUtil = require "musicutil"
local Formatters = require "formatters"
local UI = require "ui"
--local tn = require "lib/tunnel"
local tn = include('tunnels/lib/tunnel')

local pages
local SCREEN_FRAMERATE = 15
local screen_dirty = true
local current_freq = -1
local last_freq = -1
local tgroup
local tunnelmode = 1
local tunnelmodes_list
local tunnelmodes = {"off", "fractal landscape", "disemboguement", "post-horizon", "coded air", "failing lantern", "blue cat", "crawler", "hanging mosses", "rate filter"}
local tunnelcontrol = 1
local tunnelcontrols_list
local tunnelcontrols = {"manual", "input frequency", "input amplitude"}
local tunnelinput = 1
local tunnelinput_list
local tunnelinputs = {"one lane", "two lanes"}

local function update_tunnels()
  local tm = tunnelmode
  local tg = tgroup
  tn.randomize(tm, tg)
end

local function update_freq(freq)
  current_freq = freq
  if tunnelcontrol == 2 then
    
    if current_freq > 0 then last_freq = current_freq end
    if current_freq > 60 and current_freq < 260 then
      tgroup = 1
      update_tunnels()
    elseif current_freq > 260 then
      tgroup = 2
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
      tgroup = 1
      update_tunnels()
      tgroup = 2
      update_tunnels()
    end
  end
  screen_dirty = true
end

local function update_input(val)
  if val == 1 then
    -- mono
    softcut.level_input_cut(1, 1, 1.0)
	  softcut.level_input_cut(1, 2, 0.0)
	  softcut.level_input_cut(2, 1, 1.0)
	  softcut.level_input_cut(2, 2, 0.0)
	  softcut.level_input_cut(3, 1, 1.0)
	  softcut.level_input_cut(3, 2, 0.0)
	  softcut.level_input_cut(4, 1, 1.0)
	  softcut.level_input_cut(4, 2, 0.0)
	  for i = 1, 4 do
	    softcut.buffer(i, 1)
	  end
  elseif val == 2 then
    -- stereo
    softcut.level_input_cut(1, 1, 1.0)
  	softcut.level_input_cut(1, 2, 0.0)
  	softcut.level_input_cut(2, 1, 0.0)
  	softcut.level_input_cut(2, 2, 1.0)
  	softcut.level_input_cut(3, 1, 1.0)
  	softcut.level_input_cut(3, 2, 0.0)
  	softcut.level_input_cut(4, 1, 0.0)
  	softcut.level_input_cut(4, 2, 1.0)
  	softcut.buffer(1, 1)
  	softcut.buffer(2, 2)
  	softcut.buffer(3, 1)
  	softcut.buffer(4, 2)
  end
  screen_dirty = true
end

-- Encoder input
function enc(n, delta)
  
  if n == 1 then
    -- Page scroll
    pages:set_index_delta(util.clamp(delta, -1, 1), false)
  end
  
  if pages.index == 2 then
    if n == 2 then
      tunnelmodes_list:set_index_delta(util.clamp(delta, -1, 1))
      tunnelmode = tunnelmodes_list.index
      --softcut.buffer_clear()
      tgroup = 1
      update_tunnels()
      tgroup = 2
      update_tunnels()
    end
  elseif pages.index == 3 then
    if n == 2 then
      tunnelcontrols_list:set_index_delta(util.clamp(delta, -1, 1))
      tunnelcontrol = tunnelcontrols_list.index
    end
  elseif pages.index == 4 then
    if n == 2 then
      tunnelinput_list:set_index_delta(util.clamp(delta, -1, 1))
      tunnelinput = tunnelinput_list.index
      update_input(tunnelinput)
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
      tgroup = 1
      update_tunnels()
      redraw()
    elseif n == 3 then
      tgroup = 2
      update_tunnels()
      redraw()
    end
  end
end


function init()
  engine.amp(0)
  pages = UI.Pages.new(1, 4)
  tunnelmodes_list = UI.ScrollingList.new(8, 8, 1, tunnelmodes)
  tunnelcontrols_list = UI.ScrollingList.new(8, 8, 1, tunnelcontrols)
  tunnelinput_list = UI.ScrollingList.new(8, 8, 1, tunnelinputs)
  
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
  tn.init()
  -- need to set to 0 here for some reason
  for i=1, 4 do
    softcut.level(i, 0)
  end
end

function redraw()
  screen.clear()
  screen.level(6)
  
  screen.font_size(10)
  screen.font_face(22)
	screen.move(80,10)
	screen.text("tunnels")
	screen.font_size(6)
  screen.font_face(25)
  pages:redraw()
  if pages.index == 1 then
    screen.font_size(10)
    screen.font_face(22)
    screen.move(8,30)
    screen.level(2)
    screen.text("enter the")
    screen.move(8,40)
    screen.level(6)
    screen.text("mirrored terrain")
    screen.fill()
  elseif pages.index == 2 then
    tunnelmodes_list:redraw()
  elseif pages.index == 3 then
    tunnelcontrols_list:redraw()
  elseif pages.index == 4 then
    tunnelinput_list:redraw()
  end
	screen.update()
end
