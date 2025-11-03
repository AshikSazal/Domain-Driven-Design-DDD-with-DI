# Domain-Driven Design (DDD)

A Flutter project demonstrating **Domain-Driven Design (DDD)** principles.

This project is structured to separate concerns into layers, keeping **business logic independent** from infrastructure and presentation code.

---

## What is Domain-Driven Design (DDD)?

Domain-Driven Design is a software design approach that focuses on modeling **real-world business domains** in code. It emphasizes:

* **Entities**: Objects with unique identities (e.g., `Product`).
* **Value Objects**: Immutable objects without identity (e.g., `Price`).
* **Aggregates**: Clusters of entities with rules for consistency.
* **Repositories**: Interfaces to access data without exposing infrastructure details.
* **Domain Services**: Operations that don’t naturally belong to a single entity.

DDD promotes **layered architecture**:

1. **Domain Layer** – Core business logic and rules.
2. **Application Layer** – Use cases that orchestrate domain objects.
3. **Infrastructure Layer** – Database, API, network services, or local storage.
4. **Presentation Layer** – UI code (Flutter widgets, screens, state management).

---

## Project Architecture

```text
Presentation Layer (UI / Cubit)
       │
       ▼
Application Layer (UseCases)
       │
       ▼
Domain Layer (Entities, Value Objects, Services)
       │
       ▼
Infrastructure Layer (Repositories, API, DB)
```

---

### Diagram of DDD in Flutter

![DDD Layers in Flutter](https://user-images.githubusercontent.com/your-username/ddd_flutter_layers.png)

> **Explanation:**
>
> * **UI / Cubit:** Calls use cases to perform actions.
> * **UseCases:** Coordinate domain logic without knowing infrastructure details.
> * **Domain:** Contains business rules and entities.
> * **Infrastructure:** Concrete implementations of repositories or services (e.g., API calls, local DB).

---

## Getting Started

A few resources to help if you are new to Flutter:

* [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Flutter Cookbook](https://docs.flutter.dev/cookbook)
* [Flutter Documentation](https://docs.flutter.dev/)

---

### Notes

* The project uses **Cubit** for state management.
* Dependencies are injected via **dependency injection**, keeping layers decoupled.
* Replace the placeholder API endpoints in the repository with your own backend to fetch real data.

---
### Folder structure

```text
lib/
├── core/
│   └── injection/
│       └── product_container.dart   # Dependency injection setup
└── features/
    └── product/
        ├── domain/           # Pure business logic
        │   ├── entities/     # Core business objects
        │   ├── repositories/ # Abstract interfaces
        │   └── usecases/     # Business operations
        ├── application/      # Application coordination
        │   └── services/     # Use case implementations
        ├── infrastructure/   # Technical implementations
        │   └── datasource/   # Data sources (API, local)
        └── presentation/     # UI Layer
            └── pages/        # Screens/widgets
```

✅ Notes:

* `core/injection/di_container.dart` contains your **service locator / dependency injection setup** (like your `sl.registerLazySingleton` code).
* `features/product/…` keeps your DDD layers clean and modular.