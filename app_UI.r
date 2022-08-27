
ui	<-	ui <- function(request)	{fluidPage(
	titlePanel("Interactive Force Curve Graphs"),
	sidebarLayout(
		sidebarPanel(
			helpText("Ctrl and Shift to select multiple"),
			selectInput('dataSel',		label = "Switch Selection (Separate)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
			selectInput('dataLayer',	label = "Switch Selection (Overlay)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
		),
		mainPanel(
			plotOutput('graphLAYER',	height = "520px"),
			hr(),
			uiOutput('graphFORCE'),
		)
	)
)
}