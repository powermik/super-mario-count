local disp

-- setup I2c and connect display
function setup()
    -- SDA and SCL can be assigned freely to available GPIOs
    local sda = 2
    local scl = 1
    local sla = 0x3c -- 0x3c or 0x3d
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)
end 

function draw(super_mario_count, timer_id)
    disp:firstPage()
    repeat
      disp:setFont(u8g.font_fub20r)
      disp:setFontPosTop()
      disp:drawStr(0, 0, "Super Mario Count")

      disp:setFont(u8g.font_freedoomr25n)
      disp:drawStr(50, 60, super_mario_count)
    until disp:nextPage() == false
    tmr.start(timer_id)
end

return { setup: setup, draw: draw }
