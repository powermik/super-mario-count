files=(config.lua display.lua mqtt-client.lua wifi-devlol.lua tools.lua supermariocount.lua)

for file in ${files[@]}; do
  echo $file
  luatool.py --port $1 --src $file --dest $file
  if [ $? -ne 0 ]
  then
    exit 0
  fi
done
file="init.lua"
luatool.py --port $1 --src $file --dest $file
