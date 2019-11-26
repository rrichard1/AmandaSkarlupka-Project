# The analysis of anti-P1 monoclonal antibodies with regards to hemagglutinin inhibtion

This is Amanda Skarlupka's data analysis for the MADA project/paper done with R/Rmarkdown/Github. 

## Pre-requisites

The data analysis project uses R, Rmarkdown, Github, the reference manager, [Zotero](https://www.zotero.org/), and a word processor. This software stack is needed to visualize this report.

## Data & Code

All the data is contained within the data folder and all the code/rmarkdown files are within the code folder. 

### Raw Data

The raw data folder contains the original hemaglutinnin inhibition (HAI) titers of the monoclonal antibodies and the matching polyclonal sera. There are multiple sheets of the data.xlsx file. Each sheet contains either the CA/09 or P1 monoclonal or polyclonal HAI titers (four data sheets in total). The other two sheets are keys for the monoclonal antibodies used in the study and the HA antigens that the antibodies were tested against.

### Processed Data and Processing Code

The processed data folder contains the different iterations of the processed sheets of the original data.xlsx. These were clean as described in the processing_script.Rmd located in the folder "code/processing_code". They are saved as .rds files so that they can be called from within the analysis code. 

### Analysis Code

Similar to the processing code, the analysis code is also located within the code folder. The analysis code folder contains individual Rmarkdown files that each generate different figures of the document. These files can be ran in any order. The code generates either figures or tables that are saved to the results folder in png format. 

## Results

The resultant figures and tables from the analysis are saved in the results folder under their respective subfolders. The results are in a .png extension. 

## Products

The products folder contains the manuscript and bibliography. 






