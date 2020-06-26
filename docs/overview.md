---
layout: doc
title: Overview
description: "Overview of Oktopus."
nav_order: 1
permalink: /docs/overview
---

# {{site.title}} Framework
{: .fs-9 }

Oktopus simplifies the process of designing a multicast application. It focus on what the network operator needs, and not on how to calculate the results.
{: .fs-6 .fw-300 }

---

## Understanding {{site.title}}

### Framework Structure

The {{site.title}} framework has two main components: 

- **{{site.title}} APIs**: The {{site.title}} APIs provide a set of high-level interfaces to developers and network operators to define their applications. Specifically, the Application APIs define the ISP topology and available resources, the Session APIs determine the multicast session parameters including their service chaining requirements, the Routing APIs set the routing objectives (\eg min. routing cost) and link constraints.

- **Optimization engine**: The optimization engine receives these inputs from the APIs, and runs the {{site.title}} algorithm to compute the multicast distribution graphs. 
  
![]({{site.url}}{{site.baseurl}}/assets/images/overview.svg)
{{site.title}} Framework.
{: .text-center .pb-3 .pt-3}


### {{site.title}} API

The {{site.title}} API enables operators to describe *what* goals the network application needs to achieve instead of  *how* these goals are realized. For example, these APIs do not consider multicast distribution graphs because, from the operator perspective, multicast distribution graphs are the mechanisms to carry traffic.

```python
app = App(topo_path)
# Session APIs: session requirements
s = Session(addr, src, dsts, bw)
s.traverse(['fw', 'ids']) # service chaining 
# Routing APIs: routing obj. and link constraints
r = Routing()
for link in app.getLinks():
    r.addLinkCapConstraint(link, 'bps', 1e9)
r.addObjective('minRoutingCost')
# App APIs: available resources and services
app.addSessions(s); app.setRoutes(r) 
app.setAlgorithm('oktopus') # or other algorithms
app.solve() # produces a solution
```
{: .code-example}
A multicast application example using {{site.title}} API.
{: .text-center .pb-2}

In the network application, the operator specifies per-session requirements and network-wide constraints and objectives by utilizing three sets of APIs: Application, Session, and Routing.
{: .pb-4 }

#### **Application API**

This API allows the operator to control different aspects of an application such as topology, services, session, routing, and solution.

The operator can manipulate the topology using `Link`, `Node` and `Service` objects. The operator adds, deletes and gets a link or node using `add*`, `del*` and `get*` functions, respectively. In addition, the operator gets access to services at every node, and sets the available resource using `setResource` function. A list of services in the network can be retrieved by type using `getServices(type)` function (e.g., `app.getServices('fw')`). Similar to links, nodes and services, sessions can be added and deleted as well. In addition, {{site.title}} allows the operator to retrieve a group of sessions by their source. For example, `app.getSessionsBy('src', 'a')` will return all sessions with source node of `a`.  The operator uses Session APIs to manipulate sessions.

To define routing costs, constraints and objectives, the operator creates and sets a routing object using `setRoutes` function, we will define the routing API further on the section below. Since the framework is algorithm-agnostic, using  `setAlgorithm` allows users to set the engine algorithm of the application. Finally, the framework produces the application solution when the operator invokes `solve()`. Pushing OpenFlow rules is independent of the {{site.title}} APIs, allowing the operator to use multiple controller technologies.

The following piece of code shows how the Application APIs are used. This application loads the network topology from a file, modifies link capacity and delay between nodes 1 and 2, sets CPU capacity of a firewall at node 3, adds a new session, sets a routing object, sets the engine algorithm to use {{site.title}} algorithm and then calculates the solution.


```python
app = App(topo_path)
app.getLink(1,2).cap = Gb(1)
app.getLink(1,2).delay = msec(10)
fw = app.getNode(3).getService('fw') 
fw.setResource('cpu', 50) # set service fw to 50 cpu capacity
app.addSessions(Session(addr, src, dsts, bw)) # add session 
app.setAlgorithm('oktopus') 
app.solve() # produces a solution
```
{: .code-example}
An example using the Application API.
{: .text-center .pb-2}

[Head over Application API section for more detail]({{ site.baseurl }}{% link docs/oktopus_api/application_api.md %}).
{: .pb-4 }

#### **Session API**

This API creates sessions and adds constraints and requirements. 
To create a session, the operator inputs its IP address, source, destinations and bandwidth demands. If service chaining is required for the session, the operator has to create a resource requirement map. This map has two keys: service name and resource name, and its value is the required resource value. For example, the following piece of code depicts a session with two required services: firewall (`fw`) and video transcoder (`vt`) with required CPU of 10 and 20 units per second, respectively. If the operator defines service chaining requirement without a resource map, it assumes that the session does not consume service resources, and it will satisfy the order only.

```python
res_dict = {'fw':{'cpu':10}, 'vt':{'cpu':20}} # define resource consumption 
s = Session(addr, src, dsts, bw, res=res_dict)
# define session requirements
s.addConstraint('delay', msec(30)) # s.delay <= 30 msec
s.avoid(n1)
s.traverse(['fw', 'vt']) # service chaining 
```
{: .code-example}
An example using the Session API.
{: .text-center .pb-2}

Session API provides additional three APIs to define constraints and requirements. The function `addConstraint(name, val)` limits the maximum `name` value of the tree to `val`. Currently, Session API supports limiting the `delay` per session, which is useful to control per-session routing constraints. For example, the network operator may choose to limit the maximum allowed delay to 30 msec for the session shown on the piece of code above. 
For per-session traffic isolation and steering and service chaining, {Session API exposes the functions `avoid` and `traverse`, respectively. In example code, the session should avoid node `n1` and traverse two services: firewall and video transcoder.

[Head over Session API section for more detail](another-page).
{: .pb-4 }

#### **Routing API**

The operator uses this API by creating and modifying a routing object. Unlike the Session API, the Routing API defines node and link constraints and network-wide objectives. Moreover, it allows the operator to change how {{site.title}} calculates costs and consumes network resources by implementing cost and usage functions. 

The following piece of code illustrates a typical usage for the Routing API. First, the operator defines a custom functions: `cpuCostFn` and `cpuUsageFn` to modify the cost and consumption behavior of CPU resources at all services. Note that {{site.title}} algorithm allows different functions for different services, nodes and links. Then, the application adds a constraint for each link to limit the maximum bandwidth to 10^{9} bit per second (bps). It also adds a constraint for every firewall and video transcoder to limit their CPU load by 90% and 70%, respectively. The network objective in this example is to minimize the routing cost.


```python
def cpuCostFn(srv, session):
    session_cpu = session.res[srv.name]['cpu'] 
    used_cpu = srv.getUsedResource('cpu')
    cpu_cap = srv.getResource('cpu')
    return (session_cpu+used_cpu)/cpu_cap
    
def cpuUsageFn(srv, session):
    srv.addUsedResource('cpu', session.res[srv.name]['cpu'])
    
r = Routing()
for link in app.getLinks():
    # limit link to 1e9 bps
    r.addLinkCapConstraint(link, 'bps', 1e9)
    # custom cost funtion
    r.addLinkCostFn(link, 'bps', costFn=lambda l,s:(s.bw+l.used_cap)/l.cap) 
    # custom usage funtion
    r.addLinkUsageFn(link, 'bps', usageFn=lambda l,s: l.used_cap += s.bw) 
    
for node in app.getNodes():
    # limit the cpu of fw on node to 0.9
    r.addNodeCapConstraint(node, 'fw', 'cpu', 0.9)
    r.addNodeCapConstraint(node, 'vt', 'cpu', 0.7)
    for srv in node.getServices():  
        # custom cpu cost funtion of srv on node 
        r.addNodeCostFn(node, srv, 'cpu', costFn=cpuCostFn) 
        # custom cpu usage funtion of srv on node 
        r.addNodeUsageFn(node, srv, 'cpu', usageFn=cpuUsageFn)
        
r.addObjective('minRoutingCost')
app.setRoutes(r) 
```
{: .code-example}
An example using the Routing API.
{: .text-center .pb-2}

[Head over Routing API section for more detail](another-page).
{: .pb-4 }

---

[Getting Started]({{ site.baseurl }}{% link docs/getting_started.md %}){: .btn .btn-outline .btn-right}
{: .pb-4 }