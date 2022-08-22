library(readr)
library(ggplot2)
# library(shiny)
setwd("C:/Users/Jim/Documents/ThereminGoat/force-curves")

CSVs	=	list.files(recursive = TRUE, pattern = "*CSV.csv")
CSVsHR	=	list.files(recursive = TRUE, pattern = "*RAW.csv")

SELECT	=	1

TEXT	=	readLines(CSVs[SELECT],	warn = FALSE,	n = 100)
for (LINE in 1:length(TEXT))	{	if (TEXT[LINE] == "No.,Force,Unit,Displacement,Unit,Judge,Position,Time,Date,")	break	}

DATA	=	read_csv(CSVs[1], skip = LINE - 1, guess_max = 10, lazy = TRUE, show_col_types = FALSE, col_select=c("Force", "Displacement"))

BOT	=	ceiling(median(which(DATA$Displacement == max(DATA$Displacement))))
#	finds values at the maximum displacement (bottom out) and finds the middle of those measurements

DATA$Stroke	=	ordered(ifelse(1:nrow(DATA) < BOT, "Down", "Up"), c("Down", "Up"))
DATA$Reflect	=	ifelse(DATA$Stroke == "Down", DATA$Displacement, -DATA$Displacement)

ggplot(DATA[DATA$Force != 0, ], aes(x = Reflect, y = Force, color = Stroke)) + 
geom_vline(xintercept = 0) + geom_hline(yintercept = 0) + 
geom_point() + 
scale_x_continuous(name	=	"Displacement (mm)",	breaks	=	-5:5) +
scale_y_continuous(name	=	"Force (gf)",			breaks	=	seq(0, 1000, by = 20))
