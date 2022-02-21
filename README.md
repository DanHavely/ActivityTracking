# Activity Tracking Data

## Source data
Data is smartphone activity data from 30 subjects
sourced from:
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Processing

1.The files:
	+ subject_train.txt
	+ y_train.txt
	+ x_train.txt
are imported into R and bound together by the file row-order forming the training data.

2. Similarly the files:
	+ subject_test.txt
	+ y_test.txt
	+ x_test.txt
are imported into R and bound together by the file row-order forming the testing data.

3. The training data and are appended together

4. The data field names for the x_train and x_test, as given in features_info.txt are modified to be more friendly.

5. The activity field from y_train and y_test is made a factor variable and given the names from activity_labels.txt

6. Only the measure fields containing mean and standard deviation data are selected and saved as activ_track_mean_std.rds

7. The dataset activ_track_mean_std is summarised with mean of all measures by activity and subject


