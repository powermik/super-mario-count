require("tools") -- debounce function

super_mario_count = 0

local disp = require("display").setup()
local timer_id = 3
local timer_mqtt_id = 4
mqtt_client = require('mqtt-client')


-- Read retained value from server when restarting
function retrieve_last_super_mario_count()
    mqtt_client.read_topic("total", function(topic, message)
        print("Read last value: " .. message)
        super_mario_count = message
    end)
end

function draw_display()
    disp.draw(super_mario_count, timer_id)
end

function change_super_mario_count(what)
    super_mario_count = super_mario_count + what
    if super_mario_count < 0 then
      super_mario_count = 0
      return
    end
    disp.flash_title(what > 0 and "Hello Dave!" or "Logging you off", 2)

    mqtt_client.message("event", what, 0)
    mqtt_client.message("total", super_mario_count, 1)
end

function change_count_on_input(pin, direction)
    gpio.mode(pin, gpio.INT)
    gpio.trig(pin, "both", debounce(
        function (level)
            if level == gpio.HIGH then
                change_super_mario_count(direction)
            end
        end)
    )
end


mqtt_client.setup(require('config').mqtt, retrieve_last_super_mario_count)

-- set up display
tmr.register(timer_id, 100, tmr.ALARM_SEMI, draw_display)
tmr.start(timer_id)

-- set up buttons
change_count_on_input(5, 1) -- increment
change_count_on_input(6, -1) -- decrement
