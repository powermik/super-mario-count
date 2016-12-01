config = require("config")  

function load_super_mario_count()
    require("supermariocount")
end

require("wifi-devlol").start(load_super_mario_count)

