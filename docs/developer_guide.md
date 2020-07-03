---
layout: doc
title: Developer Guide
nav_order: 4
permalink: docs/developer_guide
---

# Developer Guide
{: .no_toc }


Working with {{site.title}} source code.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

The source code can be located [here](https://github.com/Oktopus-Multicast/oktopus_framework.git).
{: .pb-4 }

## Install

Install the {{site.title}} Framework module by running:
```bash
pip install -e .
```
{: .pb-4 }

## Framework Structure

The {{site.title}} Framework module has two main submodules:

- **oktopus.multicast**: This module is the [{{site.title}} APIs]({{ site.baseurl }}{% link docs/oktopus_api/oktopus_api.md %}).

- **oktopus.solver**: This module is Optimization engine, which contains the {{site.title}} algorithm.

```
oktopus
|-- multicast
|   |-- app
|   |-- session
|   |-- routing
|   +-- (other helper files and objects) ...
|
|-- solver
|   |-- oktopus_algorithm
|   |-- cplex
|   +-- (other algorithms) ...
|
+-- (other helper packages) ...
```
{{site.title}} Framework module structure.
{: .text-center}

{: .pb-4 }