Getting-and-Cleaning-Data - Course Project
=========================

##Introduction:

This repository contains my work for the course project for the Coursera course "Getting and Cleaning data"

##Input:

There are 2 types of data involved - training and test. Raw data is stored in the X files. The activity labels is stored in the Y files. The subjects are stored in the subject files.

##Script Logic and Output:

I created a script called run_analysis.R which will perform the below activities -
1. Set the working directory
2. Form the training and test dataset and merge them
3. The labels are added and only required columns with mean and std. dev. are used.
4. The output with means for all the columns are written to a tidy file.

##Codebook:

The CodeBook.md file explains the transformations performed and the resulting data and variables.
