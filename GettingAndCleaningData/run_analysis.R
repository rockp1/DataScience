#### Note to self: Uncomment the next two lines when running at home.
# dataDirectory <- "C:/WorkR/GCD_Project/"
# setwd(dataDirectory)
# 
# Please ignore this block. I was trying to read in the "Inertial Signals" too.
# But the Inertial Signals are already summarized in X. It's only for my own learning
# fileList <- list.files(path=dataDirectory, pattern=".txt")  # List of 9 files (text only)
# Read all 24 dataframes simultaneously into one list of dataframes
# dfList <- lapply(fileList, read.table)  # List with 24 elements. Each element is a dataframe
# names(dfList) <- strsplit(fileList, ".txt")  # Give each df/element a listname same as the filename
####

## Read in the main data files:
X_trainDF <- read.table("X_train.txt")
X_testDF <- read.table("X_test.txt")
subject_trainDF <- read.table("subject_train.txt")
subject_testDF <- read.table("subject_test.txt")
y_trainDF <- read.table("y_train.txt")
y_testDF <- read.table("y_test.txt")

# Part 1: Merge training and test datasets
library(plyr)  # rbind also works, but rbind.fill from 'plyr' is faster with dataframes
X <- rbind.fill(X_trainDF, X_testDF)  # X is the full dataset
y <- rbind.fill(y_trainDF, y_testDF)
subject <- rbind.fill(subject_trainDF, subject_testDF)
Xysub <- cbind(X,y,subject)  # Merge all DFs using cbind

# Variable/Column names for X is in "features.txt"
featuresDF <- read.table("features.txt", stringsAsFactors=FALSE)

# Part 2: Mean & Standard Deviation for each measurement
# Select only those columns in X that are means and stds. v indexes those columns
v <- grepl("mean()|std()", featuresDF$V2)
# http://stackoverflow.com/questions/7597559/grep-in-r-with-a-list-of-patterns
# v is a vector of TRUE or FALSE - TRUE if "mean()" OR "std()" appear in the feature list
Xnew <- X[,v]  # Subset X, to only keep the mean & std columns

#  Part 3: Descriptive names for activities
activitiesDF <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# Use activitiesDF as a LookUp Table
# http://stackoverflow.com/questions/22475400/r-replace-values-in-data-frame-using-lookup-table
ynew <- activitiesDF$V2[match(y$V1, activitiesDF$V1)]
ynew <- as.factor(ynew) # Convert the character strings to Factors

# Part 4: Descriptive labels (Column Names for X)
z <- featuresDF$V2[v]  # Keep only the mean & std Feature names
# Edit the file "features.txt" to produce the human-readable "FinalFeatures.txt"
Xlabels <- read.table("featuresFormatted.txt")
# Xlabels <- z  # for unformatted column names
colnames(Xnew) <- Xlabels$V1 # Assign these as labels for the features

# Part 5: Average of all Variables by Activity & Subject
# Merge the dataframes again, keeping only the selected variables
XYSnew <- cbind(Xnew,ynew,subject)
colnames(XYSnew) <- c(as.character(Xlabels$V1), "ynew", "subject")
meanXByActivityDF = aggregate(Xnew, by=list(ynew), FUN=mean)
meanXBySubjectDF = aggregate(Xnew, by=list(XYSnew$subject), FUN=mean)
meanXByActivityAndSubjectDF = rbind.fill(meanXByActivityDF, meanXBySubjectDF)
write.table(meanXByActivityAndSubjectDF, file="tidyDataset.txt", row.names=FALSE)


#### Printing to Multi-page PDF
# library(gridExtra)
# maxrow = 30
# npages = ceiling(nrow(meanXByActivityAndSubjectDF)/maxrow)
# pdf("tidyDataset.pdf", height=11, width=8.5, onefile=FALSE, title="Mean X by Activity and Subject", paper="letter")
# for (i in 1:npages) {idx = seq(1+((i-1)*maxrow), i*maxrow)
# grid.newpage()
# grid.table(meanXByActivityAndSubjectDF[idx, ])
# }
# dev.off()
####