files=(config.lua display.lua mqtt-client.lua wifi-devlol.lua tools.lua supermariocount.lua init.lua)

for file in ${files[@]}; do
  echo $file
  luatool.py --port $1 --src $file --dest $file -c
done
