
ui	<-	ui <- function(request)	{fluidPage(
	# titlePanel("Interactive Force Curve Graphs"),
	navbarPage("Interactive Force Curve Graphs",
		tabPanel("Separate Graphs",
			sidebarLayout(
				sidebarPanel(
					helpText("Ctrl and Shift to select multiple"),
					selectInput('dataSel',		label = "Switch Selection (Separate)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					# selectInput('dataLayer',	label = "Switch Selection (Overlay)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					# actionButton('dataSelClear',	label = "Clear Selection"),
					# actionButton('dataSelApply',	label = "Apply Selection to Overlay"),
				),
				mainPanel(
					# plotOutput('graphLAYER',	height = "520px"),
					# hr(),
					uiOutput('graphFORCE'),
				)
			)
		),
		tabPanel("Overlay Graph",
			sidebarLayout(
				sidebarPanel(
					helpText("Ctrl and Shift to select multiple"),
					# selectInput('dataSel',		label = "Switch Selection (Separate)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					selectInput('dataLayer',	label = "Switch Selection (Overlay)",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					# actionButton('dataLayerClear',	label = "Clear Selection"),
					# actionButton('dataLayerApply',	label = "Apply Selection to Separate Graphs"),
				),
				mainPanel(
					plotOutput('graphLAYER',	height = "520px"),
					# hr(),
					# uiOutput('graphFORCE'),
				)
			)
		)
	),
)	}