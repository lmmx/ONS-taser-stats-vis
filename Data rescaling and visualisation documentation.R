regionalstats0914 <- read.table('Police half-yearly taser use regional stats JanJun09 - JanJun14.tsv',sep = "\t",header=TRUE)
regionalforcestrengths <- read.table('Police workforce regional stats March 2013 - March 2014.tsv',sep = "\t",header=TRUE)

# Scaling regional force taser use by workforce numbers ('strength'), using per 100 police officers to make the data look sensible:

TasingWorkforceTable <- merge(regionalforcestrengths[,c(1,2)],regionalstats0914)
for (timeperiod in names(regionalstats0914)[2:12]){
    TasingWorkforceTable[[timeperiod]] <- round(TasingWorkforceTable[[timeperiod]] / (TasingWorkforceTable$Total.police.ranks / 100), digits = 3)
}
write.table(TasingWorkforceTable, file="Tasings per 100 police officers.tsv", sep='\t', na="NULL", col.names=TRUE, row.names=FALSE, quote=FALSE)

# Scaling regional force taser use by population size, using per 100,000 as usually done for these kinds of stats:

TasingPopulationTable <- merge(regionalforcestrengths[,c(1,4)],regionalstats0914)
for (timeperiod in names(regionalstats0914)[2:12]){
    TasingPopulationTable[[timeperiod]] <- TasingPopulationTable[[timeperiod]] / (TasingPopulationTable$Estimated.population.size / 100000)
}
write.table(TasingWorkforceTable, file="Tasings per 100,000 population.tsv", sep='\t', na="NULL", col.names=TRUE, row.names=FALSE, quote=FALSE)

library(ggplot2)
library(reshape2)
library(scales)

DELIST.DF <- NULL
counter=1
RenamedRegionsList <- character()
for (PoliceForce in (TasingPopulationTable)[,1]) {
	PoliceForceRename <- gsub(" ",".",PoliceForce)
	PoliceForceRename <- gsub("-",".",PoliceForceRename)
	RenamedRegionsList <- c(RenamedRegionsList, PoliceForceRename)
    DELIST <- paste(PoliceForceRename," = ","t(data.frame(TasingPopulationTable[",counter,",c(3:13)],row.names=NULL))",sep="")
    DELIST.DF <- rbind(DELIST.DF, DELIST)
    counter <- counter + 1
}

# the output of this loop gives the data which will be passed to the plot, rather than writing all 43 out by hand, neatly listed and separated over newlines:
regionaldata <- paste(c(DELIST.DF[,]))

# see the lines being passed on to eval with:
# cat(paste(paste(c(DELIST.DF[,])),collapse='\n'))
eval(parse(text=regionaldata))

plot_data <- 
    data.frame(TimePeriod = names(TasingPopulationTable)[c(3:13)],
			   mget(RenamedRegionsList),
			   row.names=NULL
			  )

# remove NA columns (City.of.London)
plottable_data <- plot_data[,colSums(is.na(plot_data)) != nrow(plot_data)]
plottable_data$TimePeriod <- gsub("Jun","01/06/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- gsub("Dec","01/12/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- as.Date(plottable_data$TimePeriod, format="%d/%m/%y")

plot_data_longform <- melt(plottable_data, id = "TimePeriod")
names(plot_data_longform)[2] <- 'Region'

# Loess smoothing function in ggplot2's geom_smooth() gives the following error (so have to stick to jagged lines unfortunately):
#       Error in simpleLoess(y, x, w, span, degree, parametric, drop.square, normalize, : NA/NaN/Inf in foreign function call (arg 1)

p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=Region,group=Region)) + geom_line() + xlab("Quarter") + ylab("Taser use per 100,000 population (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))
ggsave("Figure 3 - Taser use - population corrected.png", p, width = 17, height = 11)


# Now the same for scaling by police force numbers...


DELIST.DF <- NULL
counter=1
RenamedRegionsList <- character()
for (PoliceForce in (TasingWorkforceTable)[,1]) {
	PoliceForceRename <- gsub(" ",".",PoliceForce)
	PoliceForceRename <- gsub("-",".",PoliceForceRename)
	RenamedRegionsList <- c(RenamedRegionsList, PoliceForceRename)
    DELIST <- paste(PoliceForceRename," = ","t(data.frame(TasingWorkforceTable[",counter,",c(3:13)],row.names=NULL))",sep="")
    DELIST.DF <- rbind(DELIST.DF, DELIST)
    counter <- counter + 1
}

# the output of this loop gives the data which will be passed to the plot, rather than writing all 43 out by hand, neatly listed and separated over newlines:
regionaldata <- paste(c(DELIST.DF[,]))

# see the lines being passed on to eval with:
# cat(paste(paste(c(DELIST.DF[,])),collapse='\n'))
eval(parse(text=regionaldata))

plot_data <- 
    data.frame(TimePeriod = names(TasingWorkforceTable)[c(3:13)],
			   mget(RenamedRegionsList),
			   row.names=NULL
			  )

# remove NA columns (City.of.London)
plottable_data <- plot_data[,colSums(is.na(plot_data)) != nrow(plot_data)]
plottable_data$TimePeriod <- gsub("Jun","01/06/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- gsub("Dec","01/12/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- as.Date(plottable_data$TimePeriod, format="%d/%m/%y")

plot_data_longform <- melt(plottable_data, id = "TimePeriod")
names(plot_data_longform)[2] <- 'Region'

p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=Region,group=Region)) + geom_line() + xlab("Quarter") + ylab("Taser use per 100 police officers (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))
ggsave("Figure 4 - Taser use - police force size corrected.png", p, width = 14, height = 11)

# To make these graphs for broader regions and get a clearer picture, first get the list of regions and store in a list
headerlistnums <- c(1,5,11,16,22,27,34,37,43,49)
headerlistnames <- read.table("Police half-yearly use of tasers Jan09-Jun14.tsv",sep="\t",stringsAsFactors = FALSE)[c(8:60),1][headerlistnums]

# Need symmetric difference to find the rest and add them in the same order, defined as asymmetric difference of the union and intersection:
symdiff <- function( x, y) { setdiff( union(x, y), intersect(x, y))}
RegionListing <- data.frame(read.table("Police half-yearly use of tasers Jan09-Jun14.tsv",sep="\t",stringsAsFactors = FALSE)[c(8:60),1][symdiff(c(1:53),headerlistnums)],rep("",43))
names(RegionListing) <- c("Force","Region")
RegionListing$Force <- gsub("Cornwall ","Cornwall",gsub("&","and",RegionListing$Force))
RegionListing$Region <- c(rep("North East Region",3),rep("North West Region",5),rep("Yorkshire and the Humber Region",4),rep("East Midlands Region",5),rep("West Midlands Region",4),rep("East of England Region",6),rep("London Region",2),rep("South East Region",5),rep("South West Region",5),rep("Wales",4))

# Join tables before aggregating the data by region

TasingPopulationTenRegionTable <- merge(RegionListing,TasingPopulationTable)
TasingPopulationTenRegionTable <- data.frame(TasingPopulationTenRegionTable[complete.cases(TasingPopulationTenRegionTable[,5:6]),],row.names=NULL)
TasingWorkforceTenRegionTable <- merge(RegionListing,TasingWorkforceTable)
TasingWorkforceTenRegionTable <- data.frame(TasingWorkforceTenRegionTable[complete.cases(TasingWorkforceTenRegionTable[,5:6]),],row.names=NULL)

TasingPopulationTenRegionTableGrouped <- aggregate(TasingPopulationTenRegionTable[,c(3:14)], by=list(TasingPopulationTenRegionTable$Region), FUN=sum)
TasingWorkforceTenRegionTableGrouped <- aggregate(TasingWorkforceTenRegionTable[,c(3:14)], by=list(TasingWorkforceTenRegionTable$Region), FUN=sum)

names(TasingPopulationTenRegionTableGrouped)[1] <- "National.region"
names(TasingWorkforceTenRegionTableGrouped)[1] <- "National.region"

write.table(TasingPopulationTenRegionTableGrouped, file="National tasings per 100,000 population.tsv", sep='\t', na="NULL", col.names=TRUE, row.names=FALSE, quote=FALSE)
write.table(TasingWorkforceTable, file="National tasings per 100 police officers.tsv", sep='\t', na="NULL", col.names=TRUE, row.names=FALSE, quote=FALSE)

# could use dplyr and things - setdiff, union and intersect would be masked. aggregate() is a nice solution above
# from preliminary reading the group_by() dplyr function, or ddply() in plyr, on a tbl would be suitable for large datasets

# Now plot in the same way:

DELIST.DF <- NULL
counter=1
RenamedRegionsList <- character()
for (PoliceForce in (TasingPopulationTenRegionTableGrouped)[,1]) {
	PoliceForceRename <- gsub(" ",".",PoliceForce)
	PoliceForceRename <- gsub("-",".",PoliceForceRename)
	RenamedRegionsList <- c(RenamedRegionsList, PoliceForceRename)
    DELIST <- paste(PoliceForceRename," = ","t(data.frame(TasingPopulationTenRegionTableGrouped[",counter,",c(3:13)],row.names=NULL))",sep="")
    DELIST.DF <- rbind(DELIST.DF, DELIST)
    counter <- counter + 1
}

# the output of this loop gives the data which will be passed to the plot, rather than writing all 43 out by hand, neatly listed and separated over newlines:
regionaldata <- paste(c(DELIST.DF[,]))

# see the lines being passed on to eval with:
# cat(paste(paste(c(DELIST.DF[,])),collapse='\n'))
eval(parse(text=regionaldata))

plot_data <- 
    data.frame(TimePeriod = names(TasingPopulationTenRegionTableGrouped)[c(3:13)],
			   mget(RenamedRegionsList),
			   row.names=NULL
			  )

# already removed NA values (City.of.London) this time, at the aggregate() step so remove is.na() check, just change date labels
plottable_data <- plot_data
plottable_data$TimePeriod <- gsub("Jun","01/06/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- gsub("Dec","01/12/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- as.Date(plottable_data$TimePeriod, format="%d/%m/%y")

plot_data_longform <- melt(plottable_data, id = "TimePeriod")
names(plot_data_longform)[2] <- 'National.region'

# Loess smoothing function in ggplot2's geom_smooth() works for the regional data!

# Commenting out geom_line()...
# p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=National.region,group=National.region)) + geom_line() + xlab("Quarter") + ylab("Taser use per 100,000 population (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))

# Use geom_smooth now rather than geom_line, and pass it parameter fill=NA to avoid ugly grey shading around the lines
p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=National.region,group=National.region)) + geom_smooth(fill=NA) + xlab("Quarter") + ylab("Taser use per 100,000 population (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))

ggsave("Figure 5 - National taser use - population corrected.png", p, width = 17, height = 11)

# Now the same for scaling by police force numbers...

DELIST.DF <- NULL
counter=1
RenamedRegionsList <- character()
for (PoliceForce in (TasingWorkforceTenRegionTableGrouped)[,1]) {
	PoliceForceRename <- gsub(" ",".",PoliceForce)
	PoliceForceRename <- gsub("-",".",PoliceForceRename)
	RenamedRegionsList <- c(RenamedRegionsList, PoliceForceRename)
    DELIST <- paste(PoliceForceRename," = ","t(data.frame(TasingWorkforceTenRegionTableGrouped[",counter,",c(3:13)],row.names=NULL))",sep="")
    DELIST.DF <- rbind(DELIST.DF, DELIST)
    counter <- counter + 1
}

# the output of this loop gives the data which will be passed to the plot, rather than writing all 43 out by hand, neatly listed and separated over newlines:
regionaldata <- paste(c(DELIST.DF[,]))

# see the lines being passed on to eval with:
# cat(paste(paste(c(DELIST.DF[,])),collapse='\n'))
eval(parse(text=regionaldata))

plot_data <- 
    data.frame(TimePeriod = names(TasingWorkforceTenRegionTableGrouped)[c(3:13)],
			   mget(RenamedRegionsList),
			   row.names=NULL
			  )

# already removed NA values (City.of.London) this time, at the aggregate() step so remove is.na() check, just change date labels
plottable_data <- plot_data
plottable_data$TimePeriod <- gsub("Jun","01/06/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- gsub("Dec","01/12/",plottable_data$TimePeriod)
plottable_data$TimePeriod <- as.Date(plottable_data$TimePeriod, format="%d/%m/%y")

plot_data_longform <- melt(plottable_data, id = "TimePeriod")
names(plot_data_longform)[2] <- 'National.region'

# Loess smoothing function in ggplot2's geom_smooth() works for the regional data!

# Commenting out geom_line()...
# p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=National.region,group=National.region)) + geom_line() + xlab("Quarter") + ylab("Taser use per 100,000 population (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))

# Use geom_smooth now rather than geom_line, and pass it parameter fill=NA to avoid ugly grey shading around the lines
p <- ggplot(plot_data_longform,aes(x=TimePeriod,y=value,colour=National.region,group=National.region)) + geom_smooth(fill=NA) + xlab("Quarter") + ylab("Taser use per 100 police officers (log. scaled)") + scale_y_log10(labels=comma) + scale_x_date(labels = date_format("%m %Y"))
ggsave("Figure 6 - National taser use - police force size corrected.png", p, width = 14, height = 11)
