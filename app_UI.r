selectionUI	<-	function(name)	{
	ns	<-	NS(name)
	
	pasteID	<-	function(IN = NULL)	paste0("data", as.character(name), IN)
	
	tagList(
		sidebarPanel(
			helpText("Ctrl and Shift to select multiple"),
			selectInput('SEL',		label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
			selectizeInput('IZE',	label = "Switch Search",	choices = FILES,	multiple = TRUE),
			actionButton('CLR',		label = "Clear Selection"),
			actionButton('APP',		label = "Apply Selection to Other Tab"),
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
					uiOutput('Sel-graphSEP'),
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