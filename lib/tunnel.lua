-- softcut experiments

local sc = {}

function sc.init()
  print("starting softcut/tunnels")
  
	audio.level_cut(1.0)
	audio.level_adc_cut(1)
	audio.level_ext_cut(1)
  softcut.level(1,1.0)
  softcut.level(2,0.8)
  softcut.level(3,1.0)
  softcut.level(4,1.0)
	softcut.level_input_cut(1, 1, 1.0)
	softcut.level_input_cut(2, 2, 1.0)
	softcut.level_input_cut(3, 3, 1.0)
	softcut.level_input_cut(4, 4, 1.0)
	softcut.pan(1, .9)
	softcut.pan(2, .1)
	softcut.pan(3, -1)
	softcut.pan(4, 1)

  softcut.buffer(1, 1)
  softcut.play(1, 1)
	softcut.rate(1, 8)
	softcut.loop_start(1, 0)
	softcut.loop_end(1, 1)
	softcut.loop(1, 1)
	softcut.fade_time(1, 0.02)
	softcut.rec(1, 1)
	softcut.rec_level(1, 1)
	softcut.pre_level(1, 0.70)
	softcut.position(1, 0.5)
	softcut.enable(1, 1)

	softcut.filter_dry(1, 0.125);
	softcut.filter_fc(1, 1600);
	softcut.filter_lp(1, 0);
	softcut.filter_bp(1, 1.0);
	softcut.filter_rq(1, 2.0);
	
	softcut.buffer(2, 1)
	softcut.play(2, 1)
	softcut.rate(2, 8)
	softcut.loop_start(2, 0)
	softcut.loop_end(2, 1)
	softcut.loop(2, 1)
	softcut.fade_time(2, 0.02)
	softcut.rec(2, 1)
	softcut.rec_level(2, 1)
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
	softcut.pre_level(4, 0.85)
	softcut.position(4, 0)
	softcut.enable(4, 1)

	softcut.filter_dry(4, 0.125);
	softcut.filter_fc(4, 1200);
	softcut.filter_lp(4, 0);
	softcut.filter_bp(4, 1.0);
	softcut.filter_rq(4, 2.0);

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
