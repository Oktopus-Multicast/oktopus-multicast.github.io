---
layout: doc
title: Walkthrough Tutorial
description: "Walkthrough Tutorial"
nav_order: 2
permalink: /docs/walkthrough_tutorial
---

# Walkthrough Tutorial
{: .fs-9 }

This page guide you to start working with Oktopus. 
{: .fs-6 .fw-300 }

---

We will create a simple video on demand (VoD) SDN application. The objective of the application is to send the video through the network with the minimal cost. For simplicity, we will request just one multicast session. For the multicast session, we would like it to go through a firewall and then to a video transcoder.

## Setup 

In this tutorial, we will be using a docker container pre-install with all the necessarily dependencies. So before following this walkthrough, make sure to have [docker](https://docs.docker.com/get-docker/) setup on your system. Afterward, retrieve the following Oktopus docker and example repository:

* Git repository containing the example files:
    ```bash
    git clone https://github.com/Oktopus-Multicast/oktopus_example.git
    ```
* Oktopus Docker:
    ```bash
    docker pull charlee593/oktopus
    ```

## Creating an VoD SDN Application

1. Start with creating an application object and initializing the application with the Abilene network topology.
    ```python
    app = App(name='Abilene', topo='Abilene_resources.graphml')
    ```

2. Create and deploy a firewall network function on the network *node 2* and a video transcoder network function on the network *node 9*.
    ```python
    firewall = Service(name='fw', ordered=True, resources_cap={'cpu': 10})
    video_transcoder = Service(name='vt', ordered=True, resources_cap={'cpu': 10})

    app.get_node(2).add_service(firewall)
    app.get_node(9).add_service(video_transcoder)
    ```

3. Create a multicast session, where the source is *node 1* and the destinations are *node 8, 2, 7* and *9*. It demands 10 Mbps bandwidth. It requires to traverse a firewall and a video transcoder in order.

    ```python
    session = Session(addr='192.0.2.0', 
                    src=1, 
                    dsts={8, 2, 7, 9}, 
                    bw=10000000, 
                    t_class='vod',
                    res={'fw':{'cpu': 10}, 'vt':{'cpu': 10}},
                    required_services=['fw', 'vt']
                    )

    app.add_sessions([session])
    ```
4. Specify the algorithm to minimize the routing cost. Also, lets limit number of video trancoding tasks to further reduce the cost.  

    ```python
    routing = Routing()
    routing.add_objective(name='minroutingcost')

    routing.add_node_constraint(node=app.get_node(9), srv=video_transcoder, name='cpu', value=5)

    app.set_routes(routing)
    ```

5. Produce the solution.

    ```python
    app.solve()
    ```

The application should look like this:

```python
from oktopus import App, Routing, Session, Service

# Application API
app = App(name='Abilene', topo='Abilene_resources.graphml') # Load the network topology

firewall = Service(name='fw', ordered=True, resources_cap={'cpu': 10})
video_transcoder = Service(name='vt', ordered=True, resources_cap={'cpu': 10})
app.get_node(2).add_service(firewall) # add firewall network function to node 2
app.get_node(9).add_service(video_transcoder) # add video transcoder network function to node 9

# Session API
session = Session(addr='192.0.2.0', 
                  src=1, 
                  dsts={8, 2, 7, 9}, 
                  bw=10000000, 
                  t_class='vod',
                  res={'fw':{'cpu': 10}, 'vt':{'cpu': 10}},
                  required_services=['fw', 'vt'] # set service chain
                )

app.add_sessions([session]) # add multicast session


# Routing API
routing = Routing()
routing.add_objective(name='minroutingcost')

routing.add_node_constraint(node=app.get_node(9), srv=video_transcoder, name='cpu', value=5) # limit firewall usage to 5 cpu

app.set_routes(routing)

# Produces a solution
app.solve()
```

To run the application, use the provided docker.

```bash
docker run --rm -it -v="$PWD:/home" charlee593/oktopus python example.py
```

---

[Oktopus API]({{ site.baseurl }}{% link docs/oktopus_api/oktopus_api.md %}){: .btn .btn-outline .btn-right}
{: .pb-4 }