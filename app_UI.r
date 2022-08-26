
ui	<-	ui <- function(request)	{fluidPage(
	titlePanel("Interactive Force Curve Graphs"),
	sidebarLayout(
		sidebarPanel(
			selectInput('dataSel',	label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
			helpText("Ctrl and Shift to select multiple"),
		),
		mainPanel(
			uiOutput('graphFORCE'),
		)
	)
)
}