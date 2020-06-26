---
layout: doc
title: Application API
parent: Oktopus API
nav_order: 1
---

# Application API

The Application API allows the operator to control different aspects of an application such as topology, services, session, routing, and solution.

```python
add_sessions(sessions)
```

Add application sessions. 

* **Parameters** 

    * **sessions** (*dict*) – Application sessions object. 
{: .pb-2}


```python
get_link(src, dst)
```

Get network given the connected network nodes.


* **Parameters**

    
    * **src** (*str*) – The network ID of the source network node.


    * **dst** (*str*) – The network ID of the destination network node.



* **Returns**

    The network link.



* **Return type**

    Link
{: .pb-2}

```python
get_links()
```

Get network links.


* **Returns**

    A list of network links.



* **Return type**

    Link
{: .pb-2}

```python
get_node(node_id)
```

Get network node object give the ID.


* **Parameters**

    * **node_id** (*str*) – The network ID of the network node.



* **Returns**

    The network node.



* **Return type**

    Node
{: .pb-2}

```python
get_nodes()
```

Get network nodes.


* **Returns**

    A list of network nodes.



* **Return type**

    Node
{: .pb-2}

```python
get_nodes_by_service(srv_name)
```

Get network nodes containing the given network service.


* **Parameters**

    * **srv_name** (*str*) – The name of the network service.



* **Returns**

    A list of network nodes.



* **Return type**

    list
{: .pb-2}

```python
get_nodes_ids_by_service(srv_name)
```

Get network nodes IDs containing the given network service.


* **Parameters**

    * **srv_name** (*str*) – The name of the network service.



* **Returns**

    A list of network nodes IDs.



* **Return type**

    list
{: .pb-2}

```python
get_session(addr)
```

Get an application session given the session address.


* **Parameters**

    * **addr** (*str*) – IP address of the application session.



* **Returns**

    The application session.



* **Return type**

    Session
{: .pb-2}

```python
get_sessions()
```

Get application sessions.


* **Returns**
     A list of application sessions.

* **Return type**
    list
{: .pb-2}

```python
print_services()
```

Print network services deployed on the network.
{: .pb-2}

```python
set_routes(routes)
```

Set the Routing object to the application.

The Routing object is used to define routing costs, constraints and objectives of the application.


* **Parameters**

    * **routes** (*Routing*) – The Routing object.
{: .pb-2}

```python
solve(algorithm='oktopus', **kwargs)
```

Run the specified algorithm to solve the application.


* **Parameters**

    * **algorithm** (*str*) – The optimization engine algorithm.
