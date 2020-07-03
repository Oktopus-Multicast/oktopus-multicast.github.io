---
layout: doc
title: Session API
parent: Oktopus API
nav_order: 2
---

# Session API

The Session API allows the operator to creates sessions and adds constraints and requirements.
{: .pb-2}

### add_constraint(name, value)
{: .doc-api}
Add constraint requirement of the session.

Add constraint such as load, delay and hops constraints to the session requirements.

* **Parameters**

    * **name** (*str*) – Constraint name.


    * **value** (*int** or **float*) – Constraint value.



### avoid_links(links)
{: .doc-api}
Specify network links to avoid for the session.


* **Parameters**

  * **links** (*list*) – List of network links.



### avoid_nodes(nodes)
{: .doc-api}
Specify network nodes to avoid for the session.


* **Parameters**

  * **nodes** (*list*) – List of network nodes.



### avoid_sessions(sessions)
{: .doc-api}
Specify session to avoid for the session.


* **Parameters**

   * **sessions** (*list*) – List of network sessions.

### mod_resource_req(srv_name, res_name, value)
{: .doc-api}
Modify resource requirement of the session.

Add or update the resource consumption requirement of the session.


* **Parameters**

    
    * **srv_name** (*str*) – Network service function name.


    * **res_name** (*str*) – Resource name of the service function.


    * **value** (*int*) – The value of the the resource.



### pass_through(nodes)
{: .doc-api}
Specify network nodes requires to pass through for the session.


* **Parameters**

  * **nodes** (*list*) – List of network nodes.



### print_constraints()
{: .doc-api}
Print the constraints and requirements of the session.


### traverse(services)
{: .doc-api}
Specify the service chain requirement of the session.


* **Parameters**

  * **services** (*list*) – A order list of service function.
