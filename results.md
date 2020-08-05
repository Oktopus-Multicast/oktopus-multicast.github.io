---
title: Reproducing Results
layout: page
nav_exclude: true
search_exclude: true
---

# Reproducing Results

Please follow these instructions to reproduce the results.

## (1) Downloading the Dataset

Please download and uncompress the following files:

* Paper Dataset: [Download](https://nsl.cs.sfu.ca/projects/oktopus/paper_dataset_input_output.tar.gz)
* Full Dataset: [Download](https://nsl.cs.sfu.ca/projects/oktopus/full_dataset_input.tar.gz)
 
 The *paper dataset* file contains the inputs and outputs of the experiments mentioned in the paper, while the *full dataset* file contains the inputs of all the experiments. 
 Notice that the *paper dataset* is a representative sample of the *full dataset*.

 The file structure of the *paper dataset* file is:

 ```
 -paper_dataset_input_output
     |-paper_dataset
     |-result_summary.csv
     --topology_zoo
 ```
The relevant files/directories are the following:

* paper_dataset - the input directory
* result_summary.csv - the results file
* topology_zoo - the Internet topology zoo dataset

## (2) Running the Code
For convenience, we set up an Oktopus docker to run the experiment  

Get the docker:
```
docker pull charlee593/oktopus
```
      
To run the paper dataset:
```
docker run --rm -it -v="$PWD:/home" okevaluation run_sfc\
-o paper_dataset_input_output/paper_dataset\ 
--topology=paper_dataset_input_output/topology_zoo/
```
      
To run the full dataset:
```
docker run --rm -it -v="$PWD:/home" okevaluation run_sfc\
-o full_dataset_input/full_dataset\ 
--topology=full_dataset_input/topology_zoo/
```

