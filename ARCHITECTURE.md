# Architecture Patterns for IQPanda PDV

## Clean Architecture
Clean Architecture is a design philosophy that separates software solutions into layers to improve manageability, testability, and scalability.

### Layers
1. **Presentation Layer**: UI logic and user interaction management.
2. **Application Layer**: Business logic and application workflows.
3. **Domain Layer**: Core functionalities and the business model, independent of other layers.
4. **Infrastructure Layer**: Communication with external systems like databases and APIs.

### Principles
- **Dependency Rule**: Source code dependencies must point inwards, towards the higher-level policies.
- **Entities and Use Cases**: Focus on the core application fundamentals.

Choose clean architecture to facilitate a clear separation of concerns and enhance maintainability of IQPanda PDV application.