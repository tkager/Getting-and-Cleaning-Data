Getting-and-Cleaning-Data
=========================

Getting and Cleaning Data Course Project

**Purpose:**
The primary objective of this exercise wass acquire data, work with it, and clean it, such that it becomes "tidy"" data.

**Description:**
The data within this dataset were generated to detect activity via smartphone. Specically, 30 volunteers between the ages of 19 and 48 were selected. Data collection was partitioned into 2 sets. 70% of the participants were selected to collect training data, whereas the remaining 30% was test data. During the predefined activities, sensors collected data on 561 seperate measurements. 6 different activities were monitored. 

The data used in this exercised was derived from 8 files:
- /train/X_train.txt contains data from 70% of the participants. Each of the 7352 rows has 561 columns, corresponding to a measurement.
- /train/subject_test.txt contains 7352 rows, each identiying which user (1-30) ran the test referened in X-train.txt.
- /train/y_test.txt contains 7352 rows, each identiying the specific activity (numerically) occurring during each test.
- /test/X_test.txt contains data from 30% of the participants. Each 2947 rows has 561 columns, corresponding to a measurement.
- /test/subject_test.txt contains 2947 rows, each identiying which user (1-30) ran the test referened in X-test.txt.
- /test/y_test.txt contains 2947 rows, each identiying the specific activity (numerically) occurring during each test.
- /features.txt contains the column names. There are 561 values, which corresponding to columns within the test files.
- /activity_labels.txt contains labels which correspond to activies identified in y_test.txt

**Data Cleaning Process:**
Data cleaning is performed via a single script: run_analysis.R.

1. Acitivy_labels.txt and features.txt are read into data frames. These files are common to both the train and test data sets, as they contain lookup values.

2. /test/x_test.txt is read into "test" data frame with the column numbers defined via features (read in above).

3. /test/subject_test.txt is read into "testSubject" to provide a user identity to each measurement.

4. /test/y_test.txt is read into "test_testLabel" to label each test with a numeric id of the activity corresponding to each measurement.

5. "testSubject"", "test_testlabel" and "test" are cbind(ed) to create a "test_combined" data frame.

6. variable test_combined$activity is created via matching the test_testLabel numeric value, to the data frame subset numerically corresponding element.

7. /train/x_train.txt is read into "train" data frame with the column numbers defined via features (read in above)

8. /train/subject_test.txt is read into "trainSubject" to provide a user identity to each measurement.

9. /train/y_train.txt is read into "train_testLabel" to label each test with a numeric id of the activity corresponding to each measurement.

10. "trainSubject"", "train_testlabel" and "train" are cbind(ed) to create a "train_combined" data frame.

11. variable train_combined$activity is created via matching the train_testLabel numeric value, to the data frame subset numerically corresponding element.

12. "train_combined" and "test_combined" are further combined in a "master" data frame

13. a molten data frame "long_skinny" is created which places each observation on a single row, while eliminating unnecessary columns (columns without mean or std deviation in the name)

14. dcast is used to average measurements, by activity and subject to data frame "wide"

15. "wide" is further cleaned by renaming variables.

16. Tidy data is saved as tab delimited file.



