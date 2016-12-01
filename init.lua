config = require("config")  

function load_super_mario_count()

    local status, err = pcall(function ()
        require("supermariocount")
    end)
    if err then
        print(err)
    end
end

require("wifi-devlol").start(load_super_mario_count)

