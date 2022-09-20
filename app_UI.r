selectionUI	<-	function(name)	{
	ns	<-	NS(name)
	
	pasteID	<-	function(IN = NULL)	paste0("data", as.character(name), IN)
	
	tagList(
		sidebarPanel(
			helpText("Ctrl and Shift to select multiple"),
			selectInput(pasteID(),		label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
			selectizeInput(pasteID("IZE"),		label = "Switch Search",	choices = FILES,	multiple = TRUE),
			actionButton(pasteID("Clear"),	label = "Clear Selection"),
			actionButton(pasteID("Apply"),	label = "Apply Selection to Other Tab"),
			hr(),
			bookmarkButton(label = "Bookmark Switch Selection",	title = "Bookmark Switch Selection"),
			a("ThereminGoat.com",		href="https://www.theremingoat.com/"),
			br(),
			a("Force Curve Repository",	href="https://github.com/ThereminGoat/force-curves"),
		)
	)
}

ui	<-	ui <- function(request)	{
	navbarPage("Interactive Force Curve Graphs",
		tabPanel("Separate Graphs",
			sidebarLayout(
				selectionUI("Sel"),
				mainPanel(
					uiOutput('graphSEP'),
				)
			)
		),
		tabPanel("Overlay Graph",
			sidebarLayout(
				selectionUI("Layer"),
				mainPanel(
					plotOutput('graphLAY',	height = "520px"),
				)
			)
		),
	)
}