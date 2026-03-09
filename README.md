# WeatherApp iOS

A production-style iOS weather application built with **SwiftUI**, demonstrating scalable architecture, async networking, dependency injection, and comprehensive unit testing.

This project focuses on **engineering quality**, showcasing modern iOS development practices used in real production applications.

---

# Overview

WeatherApp allows users to:

• Search for cities using a weather API
• View current conditions and forecasts
• Save cities locally using SwiftData
• Load multiple cities concurrently
• Persist and manage saved cities

The goal of this project is to demonstrate **clean architecture, testability, and modern Swift development practices**.

---

# Key Engineering Concepts Demonstrated

This project demonstrates core engineering practices expected of modern iOS developers.

• Modular project architecture
• Dependency Injection
• Protocol-driven development
• Async/await concurrency
• State-driven UI with SwiftUI
• DTO to domain model mapping
• SwiftData persistence
• Comprehensive unit and integration testing

---

# Architecture

The project follows a **layered MVVM architecture** with dependency injection.

```
View
↓
ViewModel
↓
Service Layer
↓
Networking Layer
↓
API
```

Additional architectural layers:

```
DTO Models
↓
Mapper
↓
Domain Models
```

This separation ensures:

• Testable business logic
• Clear data transformation boundaries
• Decoupled networking
• Maintainable code structure

---

# Project Structure

```
WeatherAppiOS
│
├── Core
│   ├── DependencyInjection
│   │   └── AppContainer
│   ├── Networking
│   │   ├── Endpoint
│   │   ├── NetworkService
│   │   └── NetworkError
│   └── Mappers
│       └── WeatherMapper
│
├── Models
│   ├── API (DTO models)
│   └── Domain Models
│
├── Services
│   └── WeatherService
│
├── Protocols
│   ├── NetworkServiceProtocol
│   └── WeatherServiceProtocol
│
├── ViewModels
│   ├── WeatherViewModel
│   ├── WeatherDetailVM
│   └── CitiesListVM
│
├── SwiftData
│   └── SavedCity
│
└── View
    ├── CitiesListView
    ├── WeatherDetailView
    └── Search Results Views
```

---

# Dependency Injection

Dependencies are managed using an **AppContainer**, which provides application services and view models.

Example:

```
AppContainer
 ├── NetworkService
 ├── WeatherService
 ├── WeatherViewModel
 └── CitiesListVM
```

Benefits:

• Decouples components
• Improves testability
• Simplifies dependency management

---

# Networking Design

The networking layer is built using a **reusable endpoint system**.

Components include:

• Endpoint abstraction
• HTTPMethod definition
• NetworkService for API requests
• WeatherEndpoint for API configuration

This approach allows new API endpoints to be added without modifying the core networking system.

---

# Data Flow

### Search Flow

1. User enters text in search bar
2. `CitiesListVM` debounces the query
3. `WeatherService` fetches matching cities
4. Results are published via `searchState`
5. UI updates dynamically based on state

States include:

```
idle
loading
loaded
empty
failed
```

---

### Saved City Flow

1. User selects a city
2. Weather details load asynchronously
3. User taps **Save**
4. City is persisted using SwiftData
5. Saved cities appear in the main list

---

### Weather Loading

Saved cities are loaded concurrently using Swift Concurrency:

```
withTaskGroup
```

This allows multiple weather requests to run in parallel while keeping the UI responsive.

---

# Persistence

Saved cities are stored using **SwiftData**, Apple's modern persistence framework.

Example model:

```
@Model
final class SavedCity
```

Cities are stored with:

• unique name constraint
• creation timestamp

---

# Testing Strategy

The project includes **extensive test coverage using XCTest**.

### Unit Tests

```
WeatherViewModelTests
WeatherServiceTests
WeatherMapperTests
CitiesListVMTests
```

These tests validate:

• ViewModel state transitions
• network service behavior
• DTO to model mapping
• search logic and error handling

---

### Integration Tests

```
WeatherIntegrationTests
```

Integration tests verify:

• JSON decoding from API responses
• correct mapping to domain models

---

### Endpoint Tests

```
WeatherEndpointTests
```

These tests ensure correct URL generation and query parameters.

---

# Concurrency

The application uses **Swift Concurrency (async/await)**.

Examples include:

• asynchronous network calls
• concurrent weather loading using TaskGroup
• search request cancellation
• debounced search queries

This ensures efficient API usage and responsive UI updates.

---

# Technologies Used

Swift
SwiftUI
Swift Concurrency (async/await)
SwiftData
Combine
XCTest

---

# Running the Project

Requirements:

• Xcode 15+
• iOS 17+

Steps:

1. Clone the repository
2. Open `WeatherAppiOS.xcodeproj`
3. Build and run on simulator or device

---



# Author

Fawaz Tarar
iOS Engineer

