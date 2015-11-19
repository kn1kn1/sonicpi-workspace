["chp", "experiments", "mov_macros", "four_holes"].each{|f| load "~/github/sonicpi-workspace/lib/#{f}.rb"}; _=nil

shifts = [-5,-2,0,3].shuffle
with_fx :reverb, room: 1 do
  live_loop :aaa do
    with_fx :pitch_shift, pitch: 0 + shifts.ring.tick(:pitch) do
      sample :ambi_drone, amp: 2, beat_stretch: 16
      sample :ambi_glass_hum, amp: 1, beat_stretch: 16
    end
    sleep 16
  end
end

with_fx :reverb, room: 1 do
  live_loop :cho do
    sample :ambi_choir, amp: 2, beat_stretch: 32
    sample :loop_compus, amp: 0.125, beat_stretch: 32
    sleep 32
  end
end

with_fx :reverb, room: 1, mix: 0.7 do
  live_loop :dronz do
    use_synth [:tri, :fm].choose
    notes = [62, 64, 66, 67, 69, 71, 74]
    play notes.choose, attack: 2, release: 12, amp: 0.2, pan: rrand(0.3, 0.7)
    sleep [2, 4, 6].choose
  end
end
