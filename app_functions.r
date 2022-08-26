if (!require(readr))	install.packages('readr')
library(readr)

findDATA	=	function(FILE)	{
	TEXT	=	readLines(FILE,	warn = FALSE,	n =100)
	for (LINE in 1:length(TEXT))	{	if (TEXT[LINE] == "No.,Force,Unit,Displacement,Unit,Judge,Position,Time,Date,")	break	}
	return(read_csv(FILE, skip = LINE - 1, guess_max = 10, lazy = TRUE, show_col_types = FALSE, col_select=c("Force", "Displacement")))
}

findSTRK	=	function(IN)	{
	BOTTOM	=	ceiling(median(which(IN == max(IN))))
	
	return(	ordered(ifelse(1:length(IN) < BOTTOM, "Down", "Up"), c("Down", "Up"))	)
}

dispREFL	=	function(IN)	{	
	IN$Reflect	<-	ifelse(IN$Stroke == "Down", IN$Displacement, -IN$Displacement)
	return(IN)
}

simpsplit	=	function(...)	unlist(strsplit(...))
