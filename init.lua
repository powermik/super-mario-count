config = require("config")  
w = require("wifi-devlol")

function load_super_mario_count()
    require("supermariocount")
end

w.start(load_super_mario_count)  
