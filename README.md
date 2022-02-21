# Activity Tracking Data

## Source data
Data is smartphone activity data from 30 subjects  
Sourced from:  
[UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Processing
The files:  
	subject_train.txt		
	y_train.txt	
	x_train.txt  
are imported into R and bound together by the file row-order forming the training data.

Similarly the files:  
	subject_test.txt		
	y_test.txt	
	x_test.txt  
are imported into R and bound together by the file row-order forming the testing data.

The training data and are appended together  

The data field names for the x_train and x_test, as given in features_info.txt are modified to be more friendly.  

The activity field from y_train and y_test is made a factor variable and given the names from activity_labels.txt  

Only the measure fields containing mean and standard deviation data are selected and saved as activ_track_mean_std.rds  

The dataset activ_track_mean_std is summarised with mean of all measures by activity and subject  


