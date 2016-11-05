

super_mario_count = 0

disp = require("display")
disp.setup()
local timer_id = 0

tmr.register(timer_id, 100, tmr.ALARM_SEMI, function() disp.draw(super_mario_count, timer_id) end)
tmr.start(timer_id)

function change_super_mario_count(what)
    super_maro_count = super_mario_count + what
    // trigger mqtt calls
end

BTN_INC = 5
BTN_DEC = 6

gpio.mode(BTN_INC, gpio.INT)
function increment(level)
  change_super_mario_count(1)
  // basically loop it
  gpio.trig(BTN_INC, level == gpio.HIGH and "down" or "up")
end
gpio.trig(BTN_INC, "down", increment)

gpio.mode(BTN_DEC, gpio.INT)
function decrement(level)
  change_super_mario_count(-1)
  // basically loop it
  gpio.trig(BTN_DEC, level == gpio.HIGH and "down" or "up")
end
gpio.trig(BTN_DEC, "down", decrement)
