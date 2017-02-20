local module = {}

module.SSID = {}  
module.SSID["/dev/lol"] = "4dprinter"
module.SSID["ESP8266_OPEN"] = ""

module.mqtt = {
  host = "mqtt.devlol.org",
  port = 1883,
  id = "supermariocount" .. node.chipid(),
  endpoint = 'devlol/h19/mainroom/supermariocount/',
  user = nil,
  password = nil,
  secure = true
}

return module  
