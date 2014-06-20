CleaningDataProject
===================

This code is used to clean accelerometer data from the Samsung Galaxy S Smartphone into a tidy data set. The script performs the following actions, as annotated in the comments of the code. 

1. The code first loads the data into R program with the Read.Table command. 
2. The code binds the test and training data sets into a single data set. 
3. All columns except for the labels, mean, and std dev columns are removed
4. The data labels (walking, laying, etc) are changed from numerical codes to character strings.
5. Finally, the data is condensed into means by subject and activity. 
