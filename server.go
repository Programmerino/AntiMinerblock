package main

import (
	"github.com/NYTimes/gziphandler"
	"github.com/gin-gonic/gin"
	"github.com/turtlemonvh/gin-wraphh"
)

var (
	//Domain cannot be an IP Address, unless you are willing to sacrifice HTTPS
	domain       = "skyrisbactera.com"
	subdirectory = "/antiminerblock/"
)

func main() {
	//if domain == "" || domain == "localhost" {
	http := gin.Default()
	http.Static("/antiminerblock", "./")
	http.Use(wraphh.WrapHH(gziphandler.GzipHandler))
	http.Run(":80")
	/*} else {
	http := gin.Default()
	https := gin.Default()
	https.Static("/antiminerblock", "./")
	http.Use(wraphh.WrapHH(gziphandler.GzipHandler))
	https.Use(wraphh.WrapHH(gziphandler.GzipHandler))
	http.GET("/*path", func(c *gin.Context) {
		c.Redirect(302, "https://"+domain+subdirectory+c.Param("variable"))
	})
	*/
	//go autotls.Run(https, domain)
	//http.Run(":80")
	//}

}
