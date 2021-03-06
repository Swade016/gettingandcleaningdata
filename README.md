**Information**

This repo contains the code to clean and tidy the data obtained from: 
```
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
```

The repo should have a script, this readme file, and a codebook.  

You must run the following code and then set your working directory to the folder you have placed the data for this script to work!
```
install.packages("plyr")
install.packages("reshape2")
library(plyr)
library(reshape2)
```

**Execution Order**

1. Create a folder.
2. Save script and extracted data from above archive to the new folder.
3. The UCI HAR Dataset structure should be in the correct oder in the folders.
4. Execute run_analysis.R
5. tidy_dataset.txt should be created in the folder
6. tidy_dataset_avgs.txt should be created in the folder

**Script Output**
Expected Output from script:
```
[1] "Tidy dataset created"
```
