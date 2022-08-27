if (!require(ggplot2))	install.packages('ggplot2')
library(ggplot2)

theme_set(theme_grey(base_size = 12))

STROKEcolor	=	scale_color_manual(values = c("Down" = "black", "Up" = "darkgrey"), guide = "none")

graphSTROKE	<-	function()	{
	ggplot() +
	geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
	scale_x_continuous(name	=	"Displacement (mm)",	breaks	=	-5:5) +
	scale_y_continuous(name	=	"Force (gf)",			breaks	=	seq(0, 1000, by = 20)) +
	facet_grid(cols = vars(Stroke), scales = "free_x", labeller = labeller(Stroke = function(IN) paste0(IN, " Stroke"))) + 
	theme(legend.position = "top")
}

observeEvent(input$dataSel,	{
	FACETS	<-	tagList(
		lapply(input$dataSel, function(i)	{
			IN			<-	findDATA(i)
			IN$Stroke	<-	findSTRK(IN$Displacement)

			renderCachedPlot(	
				{	graphSTROKE() + ggtitle(paste0(unique(IN$Switch), " Force Curve")) + 
					geom_line(data =  dispREFL(IN[IN$Force !=0, ]),	aes(x = Reflect, y = Force, color = Stroke)) + STROKEcolor	},
				i,	res = 90,	sizePolicy = sizeGrowthRatio(1280, 720, 1.5)	)
		})
	)

	output$graphFORCE	<-	renderUI(FACETS)
})

observeEvent(input$dataLayer,	{
	output$graphLAYER	<-	renderPlot(	
	{	graphSTROKE() + ggtitle("Force Curve Overlay") + 
		lapply(input$dataLayer, function(i)	{
			hold	<-	findDATA(i)	;	hold$Stroke	<-	findSTRK(hold$Displacement)
			geom_line(data = dispREFL(hold),	aes(x = Reflect, y = Force, color = Switch))
		}	)
	},	res = 90)
})


