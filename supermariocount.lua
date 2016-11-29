

super_mario_count = 0

local disp = require("display")
local disp.setup()
local timer_id = 3
local timer_mqtt_id = 4

local mqtt_client = require('mqtt-client').setup(require('config').mqtt)

-- TODO Read retained value from server when restarting


function draw_display()
    disp.draw(super_mario_count, timer_id)
end

tmr.register(timer_id, 100, tmr.ALARM_SEMI, draw_display)
tmr.start(timer_id)

function change_super_mario_count(what)
    super_mario_count = super_mario_count + what
    if super_mario_count < 0 then
      super_mario_count = 0
      return
    end
    
    mqtt_client.message("event", what, 0)
    mqtt_client.message("total", super_mario_count, 1)
end

-- set up buttons
BTN_INC = 5
BTN_DEC = 6

gpio.mode(BTN_INC, gpio.INT)
function increment(level)
   if(level == gpio.LOW) then
      change_super_mario_count(1)
   end
  -- basically loop it
  gpio.trig(BTN_INC, level == gpio.HIGH and "down" or "up")
end
gpio.trig(BTN_INC, "down", increment)

gpio.mode(BTN_DEC, gpio.INT)
function decrement(level)
   if(level == gpio.LOW) then
      change_super_mario_count(-1)
   end
  -- basically loop it
  gpio.trig(BTN_DEC, level == gpio.HIGH and "down" or "up")
end
gpio.trig(BTN_DEC, "down", decrement)
