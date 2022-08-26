if (!require(ggplot2))	install.packages('ggplot2')
library(ggplot2)

STROKEcolor	=	scale_color_manual(values = c("Down" = "black", "Up" = "darkgrey"), guide = "none")

graphSTRK	<-	function(IN, NAME = NULL)	{
	ggplot(IN[IN$Force !=0, ],	aes(x = Reflect, y = Force, color = Stroke)) +
	ggtitle(paste0(NAME, " Force Curve")) +
	geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
	# geom_point() + STROKEcolor +
	geom_line() + STROKEcolor +
	scale_x_continuous(name	=	"Displacement (mm)",	breaks	=	-5:5) +
	scale_y_continuous(name	=	"Force (gf)",			breaks	=	seq(0, 1000, by = 20)) +
	facet_grid(cols = vars(Stroke), scales = "free_x")
}

observeEvent(input$dataSel,	{
	GRAPHS	<-	tagList(
		lapply(input$dataSel, function(i)	{
			DATA		<-	findDATA(i)
			DATA$Stroke	<-	findSTRK(DATA$Displacement)

			renderPlot(graphSTRK(dispREFL(DATA), gsub("(.*)/.*", "\\1", i))	)
		})
	)

	output$graphFORCE	<-	renderUI(GRAPHS)
})
