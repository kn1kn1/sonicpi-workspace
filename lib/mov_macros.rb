#
# mov_macros_2s
#
# live_loop :beat do
#   mov_macros_2s 0.1
#   sleep 2
# end
#
# live_loop :mov do
#   with_fx :lpf, cutoff: 60 do
#     #    mov_macros_2s 0.25
#     mov_macros_2b 0.75
#     sleep 2
#   end
# end
def mov_macros_2s(amp=0.1)
  use_bpm 70
  with_fx :level, amp: amp do
    in_thread do
      2.times do |i|
        s = :elec_tick

        n = [2, 4, 8].choose
        pan = rrand(-1, 0)
        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample s, pan: -pan, rate: rrand(1,4), amp: 1
        end

        pan = rrand(-1,1)
        rate = 2
        amp = 0.5
        n = [2, 4].choose
        with_fx :echo, phase: 0.5 / 8, mix: rrand(0.8,1) do
          sample s, pan: -pan, rate: rate, amp: amp
        end

        sleep 0.125
        sleep 0.125

        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample s, pan: -pan, rate: rate, amp: amp
        end
        sleep 0.125
        sleep 0.125

        use_synth :cnoise
        play :e5, release: 0.125, amp: 1
        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample s, pan: -pan, rate: rate, amp: amp
        end
        sleep 0.125
        sleep 0.125

        with_fx :echo, phase: 0.5 / 8, mix: rrand(0.8,1) do
          sample s, pan: -pan, rate: rate, amp: 1
        end

        n = [4, 4, 4, 8].choose
        pan = 0
        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample :drum_cymbal_closed, pan: -pan, rate: rrand(1,4), amp: 1
        end
        sleep 0.125
        sleep 0.125
      end
    end
  end
end

#
# mov_macros_2b
#
# live_loop :mov do
#   with_fx :lpf, cutoff: 60 do
#     #    mov_macros_2s 0.25
#     mov_macros_2b 0.75
#     sleep 2
#   end
# end
def mov_macros_2b(amp=0.1)
  use_bpm 70
  with_fx :level, amp: amp do
    in_thread do
      2.times do |i|
        sample :bd_haus, rate: 1 - 0.25 * i, amp: 5
        sample :bd_klub, rate: 1 - 0.25 * i, amp: 5
        n = [2, 4, 8].choose
        pan = rrand(-1, 0)
        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample :elec_soft_kick, pan: pan, rate: 1, amp: 1
        end
        sleep 0.25

        sleep 0.125
        #    play chord(:f2, :major), amp: 3 * i, release: 0.25
        sample :bd_haus, rate: 1 - 0.25 * i, amp: 5
        sleep 0.125

        n = [3, 4, 8].choose
        with_fx :echo, phase: 0.5 / n, mix: 0.1 do
          sample :elec_soft_kick, rate: 1, amp: 2
        end
        sleep 0.25

        sample :bd_haus, rate: 1 - 0.25 * i, amp: 2
        n = [4, 4, 4, 8].choose
        pan = 0
        with_fx :echo, phase: 0.5 / n, mix: rrand(0.8,1) do
          sample :elec_soft_kick, pan: pan, rate: 1, amp: 2
          #        sample :elec_triangle
        end
        sleep 0.25
      end
    end
  end
end
