
local module = {}

local client = nil
local options = nil

function module.connect(options)

for k,v in pairs(options) do print(k,v) end
  client:connect(options.host, options.port, options.secure,
                 function(client) print("connected") end, 
                 function(client, reason) print("failed reason: "..reason) end)

end

function module.setup(opts)
    options = opts

    client = mqtt.Client(options.id, 120, options.user, options.password)
    module.connect(options)
    module.options = options
    return module
end

function module.client()
    return client
end

function module.message(topic, message, retain)
print(topic, message, retain, client)
    client:publish(options.endpoint .. topic, message, 0, retain)
end

return module
