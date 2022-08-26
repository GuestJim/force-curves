library(shiny)
# setwd("C:/Users/Jim/Documents/ThereminGoat/force-curves")
setwd("E:/Users/Jim/My Documents/Ideas/Switch Force Curve Graphs/force-curves")
# runApp()

source("app_functions.r", local = TRUE)

CSVs	=	list.files(recursive = TRUE, pattern = "*CSV.csv")
CSVsHR	=	list.files(recursive = TRUE, pattern = "*RAW.csv")

FILES	=	as.list(setNames(CSVs, gsub("(.*)/.*", "\\1", CSVs)))

source("app_UI.r", local = TRUE)

server <- function(input, output, session) {
	observeEvent(input$dataSel,	{
		output$test	<-	renderText(input$dataSel)
	}	)
}

shinyApp(ui = ui, server = server, enableBookmarking = "url")