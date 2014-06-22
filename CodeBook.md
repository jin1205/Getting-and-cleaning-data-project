###Code Book
ID      
          The identified number for different subjects. The range is one to thirty.

ACTIVITY  
          Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone.

Other data Are the features including 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz and etc.Features are normalized and bounded within [-1,1].

##Run_analysis.R
1. Read both datasets from the downloaded file. Combine both dataset with its own subject id and activity description.
2. Merge two datasets.
3. Extracts only the measurements on the mean and standard deviation for each measurement for the time domain signals.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
