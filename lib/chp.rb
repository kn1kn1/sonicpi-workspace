def chp(synth, note, dur, amp, pan=0)
  use_synth synth
  pp = play note, amp: amp, pan: pan,
    release: dur, note_slide_shape: 7
  control pp, note: 12, note_slide: dur
end

def bd(amp=1)
  chp :beep, 35, 1, 1 * amp
  chp :fm, 80, 0.125, 2 * amp
end

def sd(amp=2)
  with_fx :distortion do
    chp :dsaw, 100, 0.125, amp
  end
end
