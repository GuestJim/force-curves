ui	<-	ui <- function(request)	{
	navbarPage("Interactive Force Curve Graphs",
		tabPanel("Separate Graphs",
			sidebarLayout(
				sidebarPanel(
					helpText("Ctrl and Shift to select multiple"),
					selectInput('dataSel',		label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					actionButton('dataSelClear',	label = "Clear Selection"),
					actionButton('dataSelApply',	label = "Apply Selection to Overlay"),
				),
				mainPanel(
					uiOutput('graphSEP'),
				)
			)
		),
		tabPanel("Overlay Graph",
			sidebarLayout(
				sidebarPanel(
					helpText("Ctrl and Shift to select multiple"),
					selectInput('dataLayer',	label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
					actionButton('dataLayerClear',	label = "Clear Selection"),
					actionButton('dataLayerApply',	label = "Apply Selection to Separate Graphs"),
				),
				mainPanel(
					plotOutput('graphLAY',	height = "520px"),
				)
			)
		)
	)
}