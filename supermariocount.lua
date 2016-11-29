

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
require("tools") -- debounce function

function change_count_on_input(pin, direction)
    gpio.mode(pin, gpio.INT)
    gpi.trig(pin, "both", debounce(
        function (level)
            if(level == gpio.high) then
                change_super_mario_count(direction)
            end
        end
    )
end

change_count_on_input(5, 1) -- increment
change_count_on_input(6, -1) -- decrement
