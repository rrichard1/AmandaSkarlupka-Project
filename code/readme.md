# Code

### Processing code

The processing code needs to be ran first. This folder contains the one file that cleans and creates the R objects used for the analysis. The processing_script imports the data from the original data file and then rearranges the data into two formats. The long/tall version of table ends in ...processed_data.rds, the wide version of the table ends in ..._full.rds.

The script documents the cleaning steps taken along with the accompanying reasons.  

### Analysis Code

After running the processing code, the individual analysis codes can be ran. There is no necessary order to run the set of .Rmd files in. For ease of interpretation the antibody_key_tab.Rmd and antigen_key_tab.Rmd can be ran first to get an understanding of the antibodies and antigens used for the assays. Then the elementary comparison between the two data sets is done in response_diversity.Rmd, followed by analysis_script.Rmd. The other scripts can be ran independently. 
