library(shiny)
# setwd("C:/Users/Jim/Documents/ThereminGoat/force-curves")
# setwd("E:/Users/Jim/My Documents/Ideas/Switch Force Curve Graphs/force-curves")
# runApp()

#	plot caching options
#	shinyOptions(cache = cachem::cache_disk(file.path(dirname(tempdir()), "myapp-cache")))
#		cache cleared when system reboots
#	shinyOptions(cache = cachem::cache_disk("./myapp-cache"))
#		cache survives rebooting

source("app_functions.r", local = TRUE)

CSVs	=	list.files(recursive = TRUE, pattern = "*CSV.csv")
CSVsHR	=	list.files(recursive = TRUE, pattern = "*RAW.csv")

FILES	=	as.list(setNames(CSVs, gsub("(.*)/.*", "\\1", CSVs)))

source("app_UI.r", local = TRUE)

server <- function(input, output, session) {
	setBookmarkExclude(c("separat-IZE","separat-CLR","separat-APP", "separat-BM","overlay-IZE","overlay-CLR","overlay-APP", "overlay-BM"))
	
	source("app_graphs.r", local = TRUE)
}

shinyApp(ui = ui, server = server, enableBookmarking = "url")