local disp
local module = { }
local title = "Super Mario Count"
local title_offset = 0
local flash_title = title -- This one will actually be rendered
local flash_until = 0
local width = 128
local height = 64
local sda = 2
local scl = 1
local sla = 0x3c -- 0x3c or 0x3d

function get_title_offset(str)
    if (disp == nil) then return end -- too soon
    if str == nil or #str == 0 then return end -- too little
    disp:setFont(u8g.font_7x14Br)
    local w = (disp:getWidth() - disp:getStrWidth(str)) / 2
    if w < 0 then
      return 0
    elseif w > disp:getWidth() / 2 then
      return disp:getWidth()
    else
      return w
    end
end

-- setup I2c and connect display
function module.setup()
    -- SDA and SCL can be assigned freely to available GPIOs
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)
    title_offset = get_title_offset(title)
    return module
end

function module.flash_title(str, seconds)
    flash_until = tmr.now() + seconds * 1000000 -- µS!
    flash_title = str
    title_offset = get_title_offset(str)
end

function module.message(str)
    disp:firstPage()
    repeat
      disp:setFontPosTop()
      disp:drawStr(0, 20, str)
    until disp:nextPage() == false
end

function module.draw(super_mario_count, timer_id)
    disp:firstPage()
    repeat
      disp:setFont(u8g.font_7x14Br)
      disp:setFontPosTop()
      if flash_time ~= 0 then
        local delta = flash_until - tmr.now()
        if tmr.now() > flash_until then
          flash_title = title
          title_offset = get_title_offset(flash_title)
          flash_until = 0
        end
      end

      disp:drawStr(title_offset, 0, flash_title)

      disp:setFont(u8g.font_freedoomr25n)
      disp:drawStr(50, 60, super_mario_count)
    until disp:nextPage() == false
    tmr.start(timer_id)
end
function module.display()
    return disp
end

return module
