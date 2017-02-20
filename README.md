
# Super Mario Count

__Replacing humans with electronics!__

## Features

 * Wemos D1 Mini (esp8266)
 * SSD1306 Display 128x64 I²C with yellow and yellow OLED display
 * Simple user interface with only two buttons to increment/decrement a decimal number.
 * Safe to resets (loads last total from mqtt broker)
 * Mqtt for NSA surveilance compliance
 * Open Source

## Instructions

* Connect display SCL (clock) to Wemos D1 pin D1 and SDA (data) to pin D2
* Connect push buttons to pin D5 and D6, don't forget a pull-down resistor to ground
* Flash esp module with firmware (.bin file)
* Write all lua files onto esp module (you can use supplied software/upload.sh)

## Todo

* Third button
* Fancy buttons from table calculator
* Center all the texts!1
* Be lazy about posting to mqtt so we can catch mistaken double input followed by a partial reverse
* Display network and strength
* Display mqtt broker stats

