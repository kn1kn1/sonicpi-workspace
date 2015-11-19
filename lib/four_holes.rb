#
# four_holes_4s
#
# live_loop :beat do
#   four_holes_4s 0.2
#   four_holes_4b 0.2
#   sleep 4
# end
def four_holes_4s(amp=0.1)
  use_bpm 70
  with_fx :level, amp: amp do
    in_thread do
      rr = scale(:e10, :aeolian).shuffle
      nn = rr.tick
      16.times do
        n = [2, 2, 2, 2, 4, 4, 8, 16].choose
        pan = rrand(-1,1)
        in_thread do
          with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
            chp :tri, nn, 0.125, 0.3, pan
          end
        end
        sleep 0.25
      end
    end
  end
end

#
# four_holes_4b
#
# live_loop :beat do
#   four_holes_4s 0.2
#   four_holes_4b 0.2
#   sleep 4
# end
def four_holes_4b(amp=0.1)
  use_bpm 70
  with_fx :level, amp: amp do
    in_thread do
      with_fx :rlpf, cutoff: 100, cutoff_slide: 1 do |c|
        [
          [1,0,1,0,0,0,0,0],
          [0,1,0,1,0,0,0,0],
          [0,0,1,0,0,0,0,0],
          [1,0,0,1,0,0,0,0]
        ].each.with_index do |pat, j|
          pat.each.with_index do |kick, k|
            bd if kick == 1
            sd if k == 4
            sleep 0.125
          end
        end
      end
    end
  end
end

def echoes(num, tonics, amp=1)
  num.times do
    sleep [0, 0.5, 0.75, 1, 1.25].choose
    rnote = chord(tonics.choose, :major).choose
    puts rnote
    rel = rrand(1.5, 3)
    play rnote,
      amp: amp, pan: rrand(-0.2, 0.2),
      attack: 0.25, release: rel
  end
end

def echoes2(num, tonics, amp=1)
  puts "num: #{num}"
  num.times do
    play chord(tonics.choose, [:m11, :m9, :major, :major7].choose),
      attack: [1, 0.75, 1.25, 1.5, 2].choose, cutoff: 80,
      amp: amp, pan: rrand(-0.2,0.2)
    sleep 1
  end
end
