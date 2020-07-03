---
layout: doc
title: Routing API
parent: Oktopus API
nav_order: 3
---

# Routing API.

The operator uses this API by creating and modifying a routing object.
Unlike the Session API, the Routing API defines node and link constraints
and network-wide objectives. Moreover, it allows the operator to change how
Oktopus calculates costs and consumes network resources by implementing cost
and usage functions.
{: .pb-2}

### add_link_constraint(link, name, value)
{: .doc-api}
Add network link constraint.


* **Parameters**

    
    * **link** (*Link*) – Network link object.


    * **name** – The name of the constraint.


    * **value** (*int*) – The value of the constraint.



### add_link_cost_fn(link, fn)
{: .doc-api}
Add custom link cost function.


* **Parameters**

    
    * **link** (*Link*) – Network link object.


    * **fn** (*function*) – The custom link cost function.



### add_link_usage_fn(link, fn)
{: .doc-api}
Add custom link usage function.


* **Parameters**

    
    * **link** (*Link*) – Network link object.


    * **fn** (*function*) – The custom link usage function.



### add_node_constraint(node, srv, name, value)
{: .doc-api}
Add network node constraint.


* **Parameters**

    
    * **node** (*Node*) – Network node object.


    * **srv** (*Service*) – Network service function.


    * **name** – The name of the constraint.


    * **value** (*int*) – The value of the constraint.



#### add_node_cost_fn(node, srv, name, fn)
Add custom node cost function.


* **Parameters**

    
    * **node** (*Node*) – Network node object.


    * **srv** – Service object.


    * **name** – Network service name.


    * **fn** (*function*) – The custom node cost function.



### add_node_usage_fn(node, srv, name, fn)
{: .doc-api}
Add custom node usage function.


* **Parameters**

    
    * **node** (*Node*) – Network node object.


    * **srv** – Service object.


    * **name** – Network service name.


    * **fn** (*function*) – The custom node usage function.



### add_objective(name)
{: .doc-api}
Add network objective.

Current objective includes ‘minmaxlinkload’, ‘minroutingcost’ and ‘minmaxnodeload’, ‘mindelay’.


* **Parameters**

    * **name** – The name of the objective.