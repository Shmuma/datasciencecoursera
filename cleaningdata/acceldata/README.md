## run_analisys.R

Transformation steps:

* loads activity labels from activity_labels.txt into data frame
* loads features data from features.txt
* find indexes of features we are interested in by using grep (only mean and std
  features)
* load data from test and train data sets by using routine read_data. It's
  logic steps:
  * read observation vector from X\_test.txt (or X\_train.txt)
  * read activity indices from y\_test.txt or y\_train.txt
  * read subject data
  * filter from observation vector only values we are interested
  * combine data into data frame
  * transform activity column into factor using activity labels
* after data read, and combined into large data frame, we split it by two
  factors - activity and subject
* splitted data is transformed to matrix with mean applied to individual columns


