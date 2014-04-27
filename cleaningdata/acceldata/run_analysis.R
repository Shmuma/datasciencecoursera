library(plyr)

data_dir <- "UCI HAR Dataset"

if (!file.exists(data_dir))
  error("No data directory found!")

# read activity labels
activity_labels <- read.delim(paste0(data_dir, "/activity_labels.txt"), sep=" ", header=F, col.names=c("idx", "label"))
features <- read.delim(paste0(data_dir, "/features.txt"), sep=" ", header=F, col.names=c("idx", "feature"))$feature
features_idx <- grep("-mean\\(\\)|-std\\(\\)", features)

read_data <- function(dir, limit = -1) {
  x <- read.fwf(paste(data_dir, dir, paste0("X_", dir, ".txt"), sep="/"), widths=rep(16,561), n=limit, buffersize=10, col.names=features)
  y <- read.table(paste(data_dir, dir, paste0("y_", dir, ".txt"), sep="/"), nrows=limit, col.names="activity")
  subj <- read.table(paste(data_dir, dir, paste0("subject_", dir, ".txt"), sep="/"), nrows=limit, col.names="subject")
  
  x <- x[,features_idx]
  
  res <- data.frame(subj, y, x)
  res$activity <- factor(res$activity, levels=activity_labels$idx, labels=activity_labels$label)
  res
}

limit <- -1
long <- rbind(read_data("test", limit), read_data("train", limit))
t <- split(long, interaction(long$activity, long$subject))

res <- ldply(t, function(x) { as.data.frame(c(x[1,1:2], colMeans(x[,3:ncol(x)]))) })
res <- subset(res, select = -c(".id"))
write.table(res, "tidy.txt")
