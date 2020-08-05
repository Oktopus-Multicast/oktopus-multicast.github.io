---
title: Reproducing Results
layout: page
nav_exclude: true
search_exclude: true
---


# Reproducing Results
        



Please follow these instructions to reproduce the results.

1. Download and uncompress the dataset:
  
Paper Dataset:
https://sfuca0-my.sharepoint.com/:u:/g/personal/carlosl_sfu_ca/EesKyEwBKIJDq9kq9w2mY00BMmq_ZFGSvkl8mfhyHccuuQ?e=1gSQj1

Full Dataset:
https://sfuca0-my.sharepoint.com/:u:/g/personal/carlosl_sfu_ca/ES9DrdXF0iBMoYTxJ_rnlisBtigvdK96coQFILf5tcU23Q?e=f4hkwt

The paper dataset contains the inputs and outputs of the experiments mentioned in the paper, while the full dataset contains only the inputs of all the experiments. 
      Notice that the paper dataset is a representative sample of the full dataset.
      
Paper dataset file structure:
-paper_dataset_input_output
    |-paper_dataset
    |-result_summary.csv
    --topology_zoo

paper_dataset - the input dataset
result_summary.csv - the output dataset
topology_zoo - Internet Topology Zoo dataset

2. For convenience, we set up an Oktopus docker to run the experiment  

Get the docker:
```
docker pull charlee593/oktopus
```
      
To run the paper dataset:
```
docker run --rm -it -v="$PWD:/home" okevaluation run_sfc  -o paper_dataset_input_output/paper_dataset --topology=paper_dataset_input_output/topology_zoo/
```
      
To run the full dataset:
```
docker run --rm -it -v="$PWD:/home" okevaluation run_sfc  -o full_dataset_input/full_dataset --topology=full_dataset_input/topology_zoo/
```

