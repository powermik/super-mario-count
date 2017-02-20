
local module = {}

local client = nil
local options = nil

function module.connect(options, connected)
  client:connect(options.host, options.port, options.secure, connected, 1,
                 function(c, reason) print("failed reason: "..reason) end)
end

function module.setup(opts, connected)
    module.options = opts

    client = mqtt.Client(module.options.id, 120, module.options.user, module.options.password)
    client:on("connect", connected)
    module.connect(module.options, connected)
    return module
end

function module.client()
    return client
end

function module.message(topic, message, retain)
    client:publish(module.options.endpoint .. topic, message, 0, retain)
end

function module.read_topic(topic, callback)
    local topic = module.options.endpoint .. topic
    print("subscribing to " .. topic)
    client:on('message', function(c, t, message)
        if t == topic then
            client:unsubscribe(topic, function() print("unsubscribed " .. topic) end)
            callback(t, message)
        end
    end)
    client:subscribe(topic, 0)
end

return module
