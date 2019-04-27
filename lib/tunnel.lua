-- softcut experiments

local sc = {}

function sc.init()
  print("entering tunnels")
  
	audio.level_cut(1.0)
	audio.level_adc_cut(1)
	audio.level_eng_cut(1)
	for i=1, 4 do
    softcut.level(i,0.0)
  end
	softcut.level_input_cut(1, 1, 1.0)
	softcut.level_input_cut(1, 2, 0.0)
	softcut.level_input_cut(2, 1, 1.0)
	softcut.level_input_cut(2, 2, 0.0)
	softcut.level_input_cut(3, 1, 1.0)
	softcut.level_input_cut(3, 2, 0.0)
	softcut.level_input_cut(4, 1, 1.0)
	softcut.level_input_cut(4, 2, 0.0)
	softcut.level_cut_cut(1, 2, 0.18)
	softcut.level_cut_cut(3, 4, 0.18)
	softcut.level_cut_cut(4, 1, 0.15)
	softcut.level_cut_cut(3, 2, 0.15)
	softcut.pan(1, 0.75)
	softcut.pan(2, 0.25)
	softcut.pan(3, 0.60)
	softcut.pan(4, 0.40)

  softcut.buffer(1, 1)
  softcut.play(1, 1)
	softcut.rate(1, 1)
	softcut.rate_slew_time(1, .05)
	softcut.loop_start(1, 0)
	softcut.loop_end(1, 5)
	softcut.loop(1, 1)
	softcut.fade_time(1, 0.2)
	softcut.rec(1, 1)
	softcut.rec_level(1, 1)
	softcut.pre_level(1, 0.70)
	softcut.position(1, 0)
	softcut.enable(1, 1)
	
	softcut.buffer(2, 1)
	softcut.play(2, 1)
	softcut.rate(2, 1)
	softcut.loop_start(2, 0)
	softcut.loop_end(2, 4)
	softcut.loop(2, 1)
	softcut.fade_time(2, 0.2)
	softcut.rec(2, 1)
	softcut.rec_level(2, 1)
	softcut.pre_level(2, 0.65)
	softcut.position(2, 0)
	softcut.enable(2, 1)
	
	softcut.buffer(3, 1)
	softcut.play(3, 1)
	softcut.rate(3, 2)
	softcut.loop_start(3, 0)
	softcut.loop_end(3, 3)
	softcut.loop(3, 1)
	softcut.fade_time(3, 0.2)
	softcut.rec(3, 1)
	softcut.rec_level(3, 1)
	softcut.pre_level(3, 0.85)
	softcut.position(3, 0)
	softcut.enable(3, 1)
	
	softcut.buffer(4, 1)
	softcut.play(4, 1)
	softcut.rate(4, -4)
	softcut.loop_start(4, 0)
	softcut.loop_end(4, 2)
	softcut.loop(4, 1)
	softcut.fade_time(4, 0.2)
	softcut.rec(4, 1)
	softcut.rec_level(4, 1)
	softcut.pre_level(4, 0.85)
	softcut.position(4, 0)
	softcut.enable(4, 1)
	
	for i=1,4 do 
    softcut.filter_dry(i, 0.125);
	  softcut.filter_fc(i, 1200);
	  softcut.filter_lp(i, 0);
	  softcut.filter_bp(i, 1.0);
	  softcut.filter_rq(i, 2.0);
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

return sc

