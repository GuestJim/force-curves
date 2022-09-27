if (!require(ggplot2))	install.packages('ggplot2')
library(ggplot2)

theme_set(theme_grey(base_size = 12))

STROKEcolor	=	scale_color_manual(values = c("Down" = "black", "Up" = "darkgrey"), guide = "none")

graphSTROKE	<-	function()	{
	ggplot() +
	geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
	scale_x_continuous(name	=	"Displacement (mm)",	breaks	=	-5:5) +
	scale_y_continuous(name	=	"Force (gf)",			breaks	=	seq(0, 1000, by = 20),	limits = c(0, NA)) +
	facet_grid(cols = vars(Stroke), scales = "free_x", labeller = labeller(Stroke = function(IN) paste0(IN, " Stroke"))) +
	theme(legend.position = "top")
}

bookmarkServer	<-	function(name)	{	moduleServer(name,	function(input, output, session)	{
	observeEvent(input$BM, session$doBookmark())
})}
#	to have a Bookmark button on both pages, it is necessary to have different IDs and to run an observer like this

clearServer	<-	function(name)	{	moduleServer(name,	function(input, output, session)	{
	observeEvent(input$CLR,	{
		updateSelectInput(inputId = "SEL", selected = "")	;	output$graph	<-	NULL
	}	)
})}

searchServer	<-	function(name)	{	moduleServer(name,	function(input, output, session)	{
	observeEvent(input$IZE,	{
		updateSelectInput(inputId = "SEL",	selected = c(input$SEL, input$IZE))
		updateSelectInput(inputId = "IZE",	selected = "")
	}	)
})}

separatServer	<-	function(name)	{	clearServer(name)	;	searchServer(name)	;	bookmarkServer(name)
	moduleServer(name,	function(input, output, session)	{
	observeEvent(list(input$SEL, input$OFF),	{	
		FACETS	<-	tagList(
			lapply(input$SEL, function(i)	{
				IN	<-	findDATA(i)	;	IN$Stroke	<-	findSTRK(IN$Displacement)
				PRE	<-	0	;	if (input$OFF)	PRE	<-	max(IN$Displacement[IN$Force == 0])

				renderCachedPlot(
					{	graphSTROKE() + ggtitle(paste0(unique(IN$Switch), " Force Curve")) +
						geom_line(data =  dispREFL(IN, PRE),	aes(x = Reflect, y = Force, color = Stroke)) + STROKEcolor	},
					cacheKeyExpr = {	list(i, isolate(input$OFF))	},
					res = 90,	sizePolicy = sizeGrowthRatio(1280, 720, 1.5)	)
			})
		)

		output$graph	<-	renderUI(FACETS)
	})
})	}

overlayServer	<-	function(name)	{	clearServer(name)	;	searchServer(name)	;	bookmarkServer(name)
	moduleServer(name,	function(input, output, session)	{
		observeEvent(list(input$SEL, input$OFF),	{
			output$graph	<-	renderPlot(
			{	graphSTROKE() + ggtitle("Force Curve Overlay") +
				lapply(input$SEL, function(i)	{
					IN	<-	findDATA(i)	;	IN$Stroke	<-	findSTRK(IN$Displacement)
					PRE	<-	0	;	if (input$OFF)	PRE	<-	max(IN$Displacement[IN$Force == 0])
					
					geom_line(data = dispREFL(IN, PRE),	aes(x = Reflect, y = Force, color = Switch))
				}	)
			},	res = 90)
			
			if (!isTruthy(input$SEL))	output$graph	<-	NULL
		})
})	}

separatServer('separat')
overlayServer('overlay')

selApply	<-	function(name, TARGET)	{
	updateSelectInput(inputId = NS(TARGET, "SEL"),	selected = input[[	NS(name, "SEL")	]])
}

observeEvent(input[[	NS("separat", "APP")	]],	selApply("separat", "overlay"))
observeEvent(input[[	NS("overlay", "APP")	]],	selApply("overlay", "separat"))
#	this is to watch the Apply buttons, piercing the namespaces, and then changing the appropriate selectInput

offApply	<-	function(name, TARGET)	{
	updateCheckboxInput(inputId = NS(TARGET, "OFF"),	value = input[[	NS(name, "OFF")	]])
}

observeEvent(input[[	NS("separat", "OFF")	]],	offApply("separat", "overlay"))
observeEvent(input[[	NS("overlay", "OFF")	]],	offApply("overlay", "separat"))
#	this is to watch the Align checkbox, piercing the namespaces, and then changing the appropriate checkbosInput