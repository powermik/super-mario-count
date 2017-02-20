
function list_fonts()
    for k, v in pairs(u8g) do
        print(k, v)
    end
end

-- https://gist.github.com/marcelstoer/59563e791effa4acb65f
function debounce (func, delay)
    local last = 0
    -- 50ms * 1000 as tmr.now() has μs resolution
    local delay = delay or 50000

    return function (...)
        local now = tmr.now()
        local delta = now - last
        -- proposed because of delta rolling over, https://github.com/hackhitchin/esp8266-co-uk/issues/2
        if delta < 0 then delta = delta + 2147483647 end;
        if delta < delay then return end;

        last = now
        return func(...)
    end
end
