-- softcut experiments

local sc = {}

function sc.init()
  print("starting softcut/tunnels")
  
	audio.level_cut(1.0)
	audio.level_adc_cut(1)
	audio.level_ext_cut(1)
  softcut.level(1,1.0)
  softcut.level(2,1.0)
  softcut.level(3,1.0)
  softcut.level(4,1.0)
  softcut.level(5,0.0)
  softcut.level(6,0.0)
	softcut.level_input_cut(1, 1, 1.0)
	softcut.level_input_cut(2, 2, 1.0)
	softcut.level_input_cut(3, 3, 1.0)
	softcut.level_input_cut(4, 4, 1.0)
	softcut.level_input_cut(5, 5, 0.0)
	softcut.level_input_cut(6, 6, 0.0)
	softcut.pan(1, .9)
	softcut.pan(2, .1)
	softcut.pan(3, -1)
	softcut.pan(4, 1)
	softcut.pan(5, .3)
	softcut.pan(6, .7)

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
	softcut.rate(5, .5)
	softcut.loop_start(5, 0)
	softcut.loop_end(5, 1.1)
	softcut.loop(5, 1)
	softcut.fade_time(5, 0.4)
	softcut.rec(5, 1)
	softcut.rec_level(5, 1)
	softcut.pre_level(5, .1)
	softcut.position(5, 0)
	softcut.enable(5, 1)
	softcut.filter_lp(5, .5);
	
	softcut.buffer(6, 1)
	softcut.play(6, 1)
	softcut.rate(6, .5)
	softcut.loop_start(6, 0)
	softcut.loop_end(6, 1.1)
	softcut.loop(6, 1)
	softcut.fade_time(6, 0.4)
	softcut.rec(6, 1)
	softcut.rec_level(6, 1)
	softcut.pre_level(6, .1)
	softcut.position(6, 0)
	softcut.enable(6, 1)
	softcut.filter_lp(6, .5);

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
end

return sc
