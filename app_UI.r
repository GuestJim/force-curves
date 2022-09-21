selectionUI	<-	function(name)	{
	ns	<-	NS(name)
	
	tagList(
		sidebarPanel(
			helpText("Ctrl and Shift to select multiple"),
			selectInput(ns('SEL'),		label = "Switch Selection",	choices = FILES,	size = 10,	multiple = TRUE,	selectize = FALSE),
			selectizeInput(ns('IZE'),	label = "Switch Search",	choices = FILES,	multiple = TRUE),
			actionButton(ns('CLR'),		label = "Clear Selection"),
			actionButton(ns('APP'),		label = "Apply Selection to Other Tab"),
			hr(),
			bookmarkButton(id = ns("BM"),	label = "Bookmark Switch Selection",	title = "Bookmark Switch Selection"),
			a("ThereminGoat.com",		href="https://www.theremingoat.com/"),
			br(),
			a("Force Curve Repository",	href="https://github.com/ThereminGoat/force-curves"),
		)
	)
}

graphUI	<-	function(name, TYPE, HEIGHT)	{
	ns	<-	NS(name)
	
	if (name == "separat")	return(	uiOutput(ns('graph'))	)
	if (name == "overlay")	return(	plotOutput(ns('graph'),	height = HEIGHT)	)
}

ui	<-	ui <- function(request)	{
	navbarPage("Interactive Force Curve Graphs",
		tabPanel("Separate Graphs",
			sidebarLayout(
				selectionUI("separat"),
				mainPanel(
					graphUI('separat'),
				)
			)
		),
		tabPanel("Overlay Graph",
			sidebarLayout(
				selectionUI("overlay"),
				mainPanel(
					graphUI('overlay',	HEIGHT = "520px"),
				)
			)
		),
	)
}