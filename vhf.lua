-- uhf channel changer
--
-- your tape transmitted thru 
-- late-night static and
-- broken antenna frequencies
--
-- KEY3: change channel  
-- KEY1 hold: tv guide
-- ENC1: volume
-- ENC2: speed
-- ENC3: pitch
--
-- change the channel to begin

engine.name = 'Glut'
local VOICES = 1
local shift = 0
local channel = 0
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
      softcut.filter_fc(1, math.random(10, 12000))
      softcut.filter_fc(3, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(1, math.random(10, 75) * .1)
      softcut.filter_rq(3, math.random(10, 75) * .1)
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
      softcut.filter_fc(2, math.random(10, 12000))
      softcut.filter_fc(4, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(2, math.random(10, 75) * .1)
      softcut.filter_rq(4, math.random(10, 75) * .1)
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
      softcut.filter_fc(1, math.random(10, 12000))
      softcut.filter_fc(3, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(1, math.random(10, 75) * .1)
      softcut.filter_rq(3, math.random(10, 75) * .1)
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
      softcut.filter_fc(2, math.random(10, 12000))
      softcut.filter_fc(4, math.random(10, 12000))
      softcut.filter_fc_mod(voice, math.random(0,10) * .1)
      softcut.filter_rq(2, math.random(10, 75) * .1)
      softcut.filter_rq(4, math.random(10, 75) * .1)
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

local function randomsample()
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "/home/we/dust/audio/tape"')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = "/home/we/dust/audio/tape/" .. filename
  end
  pfile:close()
  samp = (t[math.random(#t)])
  return (samp)
end

local function randomparams()
  params:set("1speed", math.random(-200,200))
  params:set("1jitter", math.random(0,500))
  params:set("1size", math.random(1,500))
  params:set("1density", math.random(0,512))
  params:set("1pitch", math.random(-24,0))
  params:set("1spread", math.random(0,100))
  params:set("reverb_mix", math.random(0,100))
  params:set("reverb_room", math.random(0,100))
  params:set("reverb_damp", math.random(0,100))
end

function init()
  local SCREEN_FRAMERATE = 15
  local screen_refresh_metro = metro.init()
  screen_refresh_metro.event = function()
    if screen_dirty then
      screen_dirty = false
      redraw()
    end
  end
  screen_refresh_metro:start(1 / SCREEN_FRAMERATE)
  
  local sep = ": "

  params:add_taper("reverb_mix", "*"..sep.."mix", 0, 100, 50, 0, "%")
  params:set_action("reverb_mix", function(value) engine.reverb_mix(value / 100) end)

  params:add_taper("reverb_room", "*"..sep.."room", 0, 100, 50, 0, "%")
  params:set_action("reverb_room", function(value) engine.reverb_room(value / 100) end)

  params:add_taper("reverb_damp", "*"..sep.."damp", 0, 100, 50, 0, "%")
  params:set_action("reverb_damp", function(value) engine.reverb_damp(value / 100) end)
  
  for v = 1, VOICES do
    params:add_separator()

    params:add_file(v.."sample", v..sep.."sample")
    params:set_action(v.."sample", function(file) engine.read(v, file) end)

    params:add_taper(v.."volume", v..sep.."volume", -60, 20, 0, 0, "dB")
    params:set_action(v.."volume", function(value) engine.volume(v, math.pow(10, value / 20)) end)

    params:add_taper(v.."speed", v..sep.."speed", -200, 200, 100, 0, "%")
    params:set_action(v.."speed", function(value) engine.speed(v, value / 100) end)

    params:add_taper(v.."jitter", v..sep.."jitter", 0, 500, 0, 5, "ms")
    params:set_action(v.."jitter", function(value) engine.jitter(v, value / 1000) end)

    params:add_taper(v.."size", v..sep.."size", 1, 500, 100, 5, "ms")
    params:set_action(v.."size", function(value) engine.size(v, value / 1000) end)

    params:add_taper(v.."density", v..sep.."density", 0, 512, 20, 6, "hz")
    params:set_action(v.."density", function(value) engine.density(v, value) end)

    params:add_taper(v.."pitch", v..sep.."pitch", -24, 24, 0, 0, "st")
    params:set_action(v.."pitch", function(value) engine.pitch(v, math.pow(0.5, -value / 12)) end)

    params:add_taper(v.."spread", v..sep.."spread", 0, 100, 0, 0, "%")
    params:set_action(v.."spread", function(value) engine.spread(v, value / 100) end)

    params:add_taper(v.."fade", v..sep.."att / dec", 1, 9000, 1000, 3, "ms")
    params:set_action(v.."fade", function(value) engine.envscale(v, value / 1000) end)
  end
  
  -- tunnels
  audio.level_cut(1.0)
	audio.level_adc_cut(1)
	audio.level_eng_cut(1)
  softcut.level(1,1.0)
  softcut.level(2,1.0)
  softcut.level(3,1.0)
  softcut.level(4,1.0)
  softcut.level(5,0.0)
  softcut.level(6,0.0)
	softcut.level_input_cut(1, 1, 1.0)
	softcut.level_input_cut(1, 2, 0.0)
	softcut.level_input_cut(2, 1, 0.0)
	softcut.level_input_cut(2, 2, 1.0)
	softcut.level_input_cut(3, 1, 1.0)
	softcut.level_input_cut(3, 2, 0.0)
	softcut.level_input_cut(4, 1, 0.0)
	softcut.level_input_cut(4, 2, 1.0)
	softcut.level_input_cut(5, 1, 0.0)
	softcut.level_input_cut(6, 2, 0.0)
	softcut.pan(1, 0.9)
	softcut.pan(2, 0.1)
	softcut.pan(3, 0.7)
	softcut.pan(4, 0.3)
	softcut.pan(5, 0.3)
	softcut.pan(6, 0.7)

  softcut.buffer(1, 1)
  softcut.play(1, 1)
	softcut.rate(1, 1)
	softcut.loop_start(1, 0)
	softcut.loop_end(1, 1)
	softcut.loop(1, 1)
	softcut.fade_time(1, 0.2)
	softcut.rec(1, 1)
	softcut.rec_level(1, 1)
	softcut.pre_level(1, 0.70)
	softcut.position(1, 0)
	softcut.enable(1, 1)

	softcut.filter_dry(1, 0.125);
	softcut.filter_fc(1, 1600);
	softcut.filter_lp(1, 0);
	softcut.filter_bp(1, 1.0);
	softcut.filter_rq(1, 2.0);
	
	softcut.buffer(2, 1)
	softcut.play(2, 1)
	softcut.rate(2, 1)
	softcut.loop_start(2, 0)
	softcut.loop_end(2, 1)
	softcut.loop(2, 1)
	softcut.fade_time(2, 0.2)
	softcut.rec(2, 1)
	softcut.rec_level(2, 1)
	softcut.rec_offset(2, .25)
	softcut.pre_level(2, 0.65)
	softcut.position(2, 0)
	softcut.enable(2, 1)

	softcut.filter_dry(2, 0.125);
	softcut.filter_fc(2, 1600);
	softcut.filter_lp(2, 0);
	softcut.filter_bp(2, 1.0);
	softcut.filter_rq(2, 2.0);
	
	softcut.buffer(3, 1)
	softcut.play(3, 1)
	softcut.rate(3, 2)
	softcut.loop_start(3, 0)
	softcut.loop_end(3, 1)
	softcut.loop(3, 1)
	softcut.fade_time(3, 0.2)
	softcut.rec(3, 1)
	softcut.rec_level(3, 1)
	softcut.rec_offset(3, .5)
	softcut.pre_level(3, 0.85)
	softcut.position(3, .5)
	softcut.enable(3, 1)

	softcut.filter_dry(3, 0.125);
	softcut.filter_fc(3, 1200);
	softcut.filter_lp(3, 0);
	softcut.filter_bp(3, 1.0);
	softcut.filter_rq(3, 2.0);
	
	softcut.buffer(4, 1)
	softcut.play(4, 1)
	softcut.rate(4, -4)
	softcut.loop_start(4, 0)
	softcut.loop_end(4, 1)
	softcut.loop(4, 1)
	softcut.fade_time(4, 0.2)
	softcut.rec(4, 1)
	softcut.rec_level(4, 1)
	softcut.rec_offset(4, .75)
	softcut.pre_level(4, 0.85)
	softcut.position(4, 0)
	softcut.enable(4, 1)

	softcut.filter_dry(4, 0.125);
	softcut.filter_fc(4, 1200);
	softcut.filter_lp(4, 0);
	softcut.filter_bp(4, 1.0);
	softcut.filter_rq(4, 2.0);
	
	softcut.buffer(5, 1)
	softcut.play(5, 1)
	softcut.rate(5, 1)
	softcut.loop_start(5, 0)
	softcut.loop_end(5, 2)
	softcut.loop(5, 1)
	softcut.fade_time(5, 0.4)
	softcut.rec(5, 0)
	softcut.rec_level(5, 1)
	softcut.pre_level(5, .1)
	softcut.position(5, 0)
	softcut.enable(5, 1)
	softcut.filter_bp(5, .6);
	
	softcut.buffer(6, 1)
	softcut.play(6, 1)
	softcut.rate(6, 1)
	softcut.loop_start(6, 0)
	softcut.loop_end(6, 2)
	softcut.loop(6, 1)
	softcut.fade_time(6, 0.4)
	softcut.rec(6, 0)
	softcut.rec_level(6, 1)
	softcut.pre_level(6, .1)
	softcut.position(6, 0)
	softcut.enable(6, 1)
	softcut.filter_bp(6, .4);

  --params:add_separator()
  local p = softcut.params()
  params:add(p[1].rate)
  params:add(p[2].rate)
  params:add(p[3].rate)
  params:add(p[4].rate)
  params:add(p[1].fade_time)
  params:add(p[2].fade_time)
  params:add(p[3].fade_time)
  params:add(p[4].fade_time)
  params:add(p[1].pre_level)
  params:add(p[2].pre_level)
  params:add(p[3].pre_level)
  params:add(p[4].pre_level)
  params:add(p[1].filter_lp)
  params:add(p[2].filter_lp)
  params:add(p[3].filter_lp)
  params:add(p[4].filter_lp)
  
  params:bang()
end

local function reset_voice()
  engine.seek(1, 0)
end

local function start_voice()
  reset_voice()
  engine.gate(1, 1)
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
    udpate_tunnels(1)
    udpate_tunnels(2)
    udpate_tunnels(3)
    udpate_tunnels(4)
    redraw()
  elseif n == 2 then
    params:delta("1volume", d)
    screen_dirty = true
  elseif n == 3 then
    params:delta("1speed", d)
    screen_dirty = true
  end
end

function key(n, z)
  if n == 1 then
    softcut.buffer_clear()
    shift = z
    screen_dirty = true
  elseif n == 2 then
    udpate_tunnels(1)
    udpate_tunnels(2)
    udpate_tunnels(3)
    udpate_tunnels(4)
  elseif n == 3 then
    if z == 1 then
      -- nothing for now
    else
      channel = channel + 1
      params:set("1sample", randomsample())
      randomparams()
      start_voice()
      screen_dirty = true
    end
  end
end

local function printround(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function drawtv()
  --random screen pixels
  local heighta = math.random(1,30)
  local heightb = math.random(31,64)
  for x=1,heighta do
    for i=1,128 do
      screen.level(math.random(0, 4))
      screen.rect(i,x,1,1)
      screen.fill()
    end
  end
  for x=heighta+1,heightb-1 do
    for i=1,128 do
      screen.level(math.random(0, 6))
      screen.rect(i,x,1,1)
      screen.fill()
    end
  end
  for x=heightb,64 do
    for i=1,128 do
      screen.level(math.random(0, 10))
      screen.rect(i,x,1,1)
      screen.fill()
    end
  end
  
  screen.level(0)
  screen.rect(1,50,128,10)
  screen.fill()
  screen.level(3)
  screen.rect(1,54,128,2)
  screen.fill()
	screen.font_face(1)
  screen.font_size(8)
	screen.move(10,58)
	screen.level(10)
	screen.text(printmode)
end

local function cleanfilename()
  return(string.gsub(params:get("1sample"), "/home/we/dust/audio/tape/", ""))
end

local function guidetext(parameter, measure)
  return(parameter .. ": " .. printround(params:get("1"..parameter), 1) .. measure)
end

function redraw()
  screen.clear()
  screen.aa(1)
  screen.line_width(1.0)
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
  
  if shift == 0 then
    drawtv()
  else 
    -- tv guide
    screen.level(2)
    screen.rect(0,0,128,30)
    screen.fill()
    screen.level(3)
    screen.rect(0,30,128,42)
    screen.fill()
    screen.level(4)
    screen.rect(0,43,128,21)
    screen.fill()
    screen.font_face(1)
    screen.font_size(8)
    screen.move(3, 10)
    screen.level(0)
    screen.text(cleanfilename())
    screen.move(2, 8)
    screen.level(13)
    screen.text(cleanfilename())
    -- glitch title
    screen.move(35, 28)
    screen.level(1)
    screen.text(cleanfilename())
    screen.move(55, 52)
    screen.level(3)
    screen.text(cleanfilename())
    
    screen.level(0)
    screen.move(3, 18)
    screen.text(guidetext("speed", "%"))
    screen.level(13)
    screen.move(2, 16)
    screen.text(guidetext("speed", "%"))
    screen.level(0)
    screen.move(3, 26)
    screen.text(guidetext("jitter", "ms"))
    screen.level(13)
    screen.move(2, 24)
    screen.text(guidetext("jitter", "ms"))
    screen.level(1)
    screen.move(3, 34)
    screen.text(guidetext("size", "ms"))
    screen.level(14)
    screen.move(2, 32)
    screen.text(guidetext("size", "ms"))
    screen.level(2)
    screen.move(3, 42)
    screen.text(guidetext("density", "hz"))
    screen.level(15)
    screen.move(2, 40)
    screen.text(guidetext("density", "hz"))
    screen.level(2)
    screen.move(3, 50)
    screen.text(guidetext("pitch", "st"))
    screen.level(15)
    screen.move(2, 48)
    screen.text(guidetext("pitch", "st"))
    screen.level(2)
    screen.move(3,58)
    screen.text(guidetext("spread", "%"))
    screen.level(15)
    screen.move(2,56)
    screen.text(guidetext("spread", "%"))
  end

  -- channel number
  screen.level(0)
  screen.rect(109,6,18,16)
  screen.fill()
  screen.level(2)
  screen.rect(108,4,18,16)
  screen.fill()
  screen.font_face(3)
  screen.font_size(12)
  screen.move(111,17)
  screen.level(0)
  screen.text(channel)
  screen.move(110,15)
  screen.level(15)
  screen.text(channel)
  
  screen.update()
end