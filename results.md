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

      <!--
For the experiment where we wish to observe the effect of the number of sessions, the dataset is set in the following:

Number of sessions: [1000, 1500, 2000, 3000, 4000]
Topology: Ion, Dfn, Colt
Service chain length: random([3, 4, 5, 6])
Percentage of sessions with services: 100%
Order Type: 1 (partial)
Receivers Percentage: random([(0.1, .1), (0.2, .2), (0.3, .3), (0.4, .4)]) (10% of choosing 10%)
Bandwidth demand : random([(2000000, .21), (7200000, .57), (18000000, .22)]) (21% of choosing 2000000bps)
 Auxilary service deployment: 25%

To observe the effect of the service chain length, the dataset is set in the following:

Service chain length: [3, 4, 5, 6]
Number of sessions: 4000
Topology: Ion
Order Type: 1 (partial)
Receivers Percentage: random([(0.1, .1), (0.2, .2), (0.3, .3), (0.4, .4)])
Bandwidth demand : random([(2000000, .21), (7200000, .57), (18000000, .22)]) 
Auxilary service deployment: 25%

To observe the effect of the order type, the dataset is set in the following:

Order Type: [1 (partial), 2 (random)]
Number of sessions: 4000
Topology: Ion
Service chain length: random([3, 4, 5, 6])
Receivers Percentage: random([(0.1, .1), (0.2, .2), (0.3, .3), (0.4, .4)])
Bandwidth demand : random([(2000000, .21), (7200000, .57), (18000000, .22)]) 
Auxilary service deployment: 25%

To observe the effect of the receivers density, the dataset is set in the following:

Receivers Percentage: [10%, 20%, 30%, 40%]
Number of sessions: 4000
Topology: Ion
Service chain length: random([3, 4, 5, 6])
Order Type:  1 (partial)
Bandwidth demand : random([(2000000, .21), (7200000, .57), (18000000, .22)]) 
Auxilary service deployment: 25%

To observe the effect of the service deployment, the dataset is set in the following:
   
Auxilary service deployment: [5%, 15%, 25%, 35%, 45%]
Number of sessions: 4000
Topology: Ion
Service chain length: random([3, 4, 5, 6])
Percentage of sessions with services: 100%
Order Type:  1 (partial)
Receivers Percentage: random([(0.1, .1), (0.2, .2), (0.3, .3), (0.4, .4)])
Bandwidth demand : random([(2000000, .21), (7200000, .57), (18000000, .22)]) 
-->
      
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

