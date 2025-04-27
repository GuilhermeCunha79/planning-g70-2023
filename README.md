# Planning-G70-2023: Route Planning & Optimization System

This repository contains the Planning module for the Logistics Management System developed by Group 70 in 2023. The project was built as part of LAPR5 (Laboratory of Software Architecture and Design 5) at ISEP (Instituto Superior de Engenharia do Porto).

## 📋 Table of Contents

- [🚀 Overview](#-overview)
- [🛠️ Technologies](#️-technologies)
- [📂 Repository Structure](#-repository-structure)
- [🚦 Features](#-features)
- [🔧 Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Running the System](#running-the-system)
  - [Running Tests](#running-tests)
- [🧠 Logic Programming](#-logic-programming)
- [🧩 Algorithms](#-algorithms)
- [🔄 Integration](#-integration)
- [👥 Contributors](#-contributors)

## 🚀 Overview

The Planning module is responsible for advanced route planning and optimization within the Logistics Management System. It leverages Prolog's logical programming capabilities to implement sophisticated algorithmic solutions for vehicle routing problems, delivery scheduling, and route optimization to minimize costs and delivery times while maximizing efficiency.

This module integrates with other components of the Logistics Management System to provide comprehensive planning capabilities for fleet management operations.

## 🛠️ Technologies

- **Prolog** - Logic programming language (SWI-Prolog)
- **HTTP** - For API endpoints via Prolog's HTTP libraries
- **JSON** - For data interchange
- **Constraint Logic Programming** - For complex constraint solving
- **Docker** - Containerization (optional)
- **Git** - Version control

## 📂 Repository Structure

```
/
├── src/                      # Source code
│   ├── algorithms/           # Planning algorithms
│   │   ├── genetic.pl        # Genetic algorithm implementations
│   │   ├── constraints.pl    # Constraint satisfaction problems
│   │   └── optimization.pl   # Optimization predicates
│   ├── domain/               # Domain knowledge representation
│   │   ├── vehicles.pl       # Vehicle facts and rules
│   │   ├── routes.pl         # Route definitions
│   │   └── locations.pl      # Location data
│   ├── api/                  # HTTP API endpoints
│   │   ├── server.pl         # HTTP server configuration
│   │   └── handlers.pl       # API request handlers
│   ├── utils/                # Utility predicates
│   └── main.pl               # Main entry point
├── tests/                    # Test files
│   ├── unit/                 # Unit tests
│   └── integration/          # Integration tests
├── data/                     # Sample data files
├── docs/                     # Documentation
├── config.pl                 # Configuration settings
├── Dockerfile                # Docker configuration
└── README.md                 # Project documentation
```

## 🚦 Features

- **Route Optimization** - Efficient routing algorithms using constraint logic programming
- **Delivery Planning** - Scheduling of deliveries with time windows
- **Vehicle Assignment** - Optimal assignment of vehicles to routes
- **Multi-Stop Planning** - Handling complex routes with multiple deliveries
- **Constraint-Based Planning** - Support for vehicle capacity, time windows, and other constraints
- **Heuristic Search** - Implementation of heuristic algorithms for route optimization
- **Performance Analytics** - Metrics and analysis of route efficiency

## 🔧 Getting Started

### Prerequisites

- [SWI-Prolog](https://www.swi-prolog.org/download/stable) (version 8.4 or later)
- Basic understanding of Prolog and logic programming
- curl, wget, or Postman (for API testing)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/GuilhermeCunha79/planning-g70-2023.git
   cd planning-g70-2023
   ```

2. Ensure SWI-Prolog is installed:
   ```bash
   swipl --version
   ```

### Configuration

1. Review and adjust settings in `config.pl` if needed:
   ```prolog
   % Server configuration
   server_port(8000).
   server_timeout(60).
   
   % Algorithm parameters
   population_size(100).
   mutation_rate(0.05).
   ```

### Running the System

1. Start the Prolog system:
   ```bash
   swipl -s src/main.pl
   ```

2. In the Prolog console, start the server:
   ```prolog
   ?- start_server.
   ```

3. The API will be available at `http://localhost:8000/api/planning`

4. Example query using curl:
   ```bash
   curl -X POST http://localhost:8000/api/planning/optimize \
     -H "Content-Type: application/json" \
     -d '{"vehicles": 3, "locations": [...], "constraints": {...}}'
   ```

### Running Tests

Execute the test suite in SWI-Prolog:
```bash
swipl -s tests/run_tests.pl
```

## 🧠 Logic Programming

This module leverages Prolog's logic programming paradigm for several advantages:

1. **Declarative Problem Solving** - Problems are expressed as logical relationships rather than step-by-step procedures
2. **Constraint Satisfaction** - Powerful built-in constraint solving capabilities
3. **Backtracking Search** - Automatic exploration of solution spaces
4. **Knowledge Representation** - Natural representation of domain knowledge as facts and rules

These capabilities make Prolog particularly well-suited for complex planning and optimization problems in logistics.

## 🧩 Algorithms

This module implements several algorithms for route planning and optimization:

1. **Genetic Algorithms** - Implemented in Prolog for solving Vehicle Routing Problems (VRP)
2. **Constraint Logic Programming (CLP)** - For handling complex constraints
3. **A* Search** - For pathfinding between locations
4. **Simulated Annealing** - For local optimization
5. **Branch and Bound** - For systematic exploration of solution spaces

Algorithm parameters can be tuned via the API or configuration files.

## 🔄 Integration

The Planning module integrates with:

- **Logistics Module (.NET)** - For warehouse and inventory data
- **Fleet Management Module (Node.js)** - For vehicle information and status
- **SPA Frontend (Angular)** - For visualization and user interaction

Integration is facilitated through HTTP APIs with JSON data interchange.

## 👥 Contributors

This project was developed by ISEP students from Group 70 (2022):
- Guilherme Cunha
- Beatriz Cardoso
- Hugo Carvalho
- Érica Lopes

---

---

This project is part of the Software Engineering curriculum at ISEP, developed for LAPR5.
