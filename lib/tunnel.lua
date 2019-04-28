-- softcut experiments

local tn = {}

function tn.init()
  print("entering tunnels")
  
	audio.level_cut(1.0)
	audio.level_adc_cut(1)
	audio.level_eng_cut(1)
	softcut.level_cut_cut(1, 2, 0.18)
	softcut.level_cut_cut(3, 4, 0.18)
	softcut.level_cut_cut(4, 1, 0.15)
	softcut.level_cut_cut(3, 2, 0.15)

  for i=1, 4 do
    softcut.level_input_cut(i, 1, 1.0)
    softcut.level_input_cut(i, 2, 0.0)
    
    softcut.buffer(i, 1)
    softcut.play(i, 1)
  	softcut.rate(i, 1)
  	--softcut.rate_slew_time(i, .15)
  	softcut.loop_start(i, 0)
  	softcut.loop_end(i, i+1)
  	softcut.loop(i, 1)
  	softcut.fade_time(i, 0.2)
  	softcut.rec(i, 1)
  	softcut.rec_level(i, 1)
  	softcut.pre_level(i, 0.70)
  	softcut.position(i, 0)
  	softcut.enable(i, 1)
    softcut.filter_dry(i, 0.125)
	  softcut.filter_fc(i, 1200)
	  softcut.filter_lp(i, 0)
	  softcut.filter_bp(i, 1.0)
	  softcut.filter_rq(i, 2.0)
  end

  params:add_separator()
  for i=1, 4 do
    params:add{id="delay_rate"..i, name="delay rate"..i, type="control", 
    controlspec=controlspec.new(-8, 8, 'lin', 0, 0, ""),
    action=function(x) softcut.rate(i,x) end}
  
    params:add{id="delay_feedback"..i, name="delay feedback"..i, type="control", 
    controlspec=controlspec.new(0,1.0,'lin',0,0,""),
    action=function(x) softcut.pre_level(i,x) end}
  
    params:add{id="fade_time"..i, name="fade"..i, type="control", 
    controlspec=controlspec.new(0, 1, 'lin', 0, 0, ""),
    action=function(x) softcut.fade_time(i,x) end}
  
    params:add{id="filter_fc"..i, name="filter cutoff"..i, type="control", 
    controlspec=controlspec.new(10, 12000, 'exp', 1, 12000, "Hz"),
    action=function(x) softcut.filter_fc(i,x) end}
  end
end

function tn.pan(tunnelgroup)
  if tunnelgroup == 1 then
    softcut.pan(1, math.random(75, 90) * 0.01)
    softcut.pan(4, math.random(25, 45) * 0.01)
    
  elseif tunnelgroup == 2 then
    softcut.pan(2, math.random(10, 25) * 0.01)
    softcut.pan(3, math.random(55, 75) * 0.01)
  end
end

function tn.randomize(mode, tunnelgroup)
  -- set panning
  tn.pan(tunnelgroup)
    
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
	if mode == 1 then
	  for i=1, 4 do
	    softcut.level(i, 0)
	  end

	-- fractal landscape
	elseif mode == 2 then
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
  elseif mode == 3 then
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
  elseif mode == 4 then
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
  elseif mode == 5 then
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
  elseif mode == 6 then
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
	elseif mode == 7 then
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
	elseif mode == 8 then
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

return tn
