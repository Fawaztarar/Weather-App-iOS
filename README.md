# WeatherApp iOS

A production-style iOS weather application built with **UIKit**, demonstrating scalable architecture, async networking, dependency injection, and comprehensive unit testing.

This project focuses on **engineering quality**, showcasing modern iOS development practices used in real production applications.

---

# Overview

WeatherApp allows users to:

• Search for cities using a weather API
• View current conditions and forecasts
• Save cities locally using SwiftData
• Cache weather responses using Realm
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
• Diffable Data Sources for state-driven UI
• DTO to domain model mapping
• Hybrid persistence (SwiftData + Realm)
• Comprehensive unit and integration testing
• UICollectionView Compositional Layout
• Programmatic UIKit UI (no storyboards)
• Reusable cell-based UI architecture

---

# Architecture

The project follows a **layered MVVM architecture** with dependency injection.

```
UIKit ViewControllers
↓
ViewModels
↓
Service Layer
↓
Networking Layer
↓
API
```

# UIKit Implementation

The user interface is implemented entirely using **programmatic UIKit**, following modern Apple recommended practices.

Key UIKit technologies used:

• UITableView for the cities list  
• UICollectionView with Compositional Layout for weather details  
• Diffable Data Source for safe UI updates  
• Reusable UICollectionViewCell components  
• UISearchController for city search  
• Swipe actions for city deletion  




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
├── UIKit
│   ├── Cells
│   │   ├── CityTableViewCell
│   │   ├── HeroWeatherCell
│   │   ├── HourlyWeatherCell
│   │   └── DailyWeatherCell
│   │
│   ├── Controller
│   │   ├── CitiesListViewController
│   │   └── WeatherDetailViewController
│   │
│   ├── Layout
│   │   └── WeatherDetailLayout
│   │
│   └── Utils
│       ├── WeatherIconLoader
│       └── FloatingActionButton
```
The Weather Detail screen is built using **UICollectionViewCompositionalLayout**, enabling flexible multi-section layouts.


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

The application supports **local data persistence and caching** using both **SwiftData** and **Realm**.

### SwiftData

Saved cities are persisted using **SwiftData**, Apple's modern persistence framework.

Example model:

```
@Model
final class SavedCity
```

 Cities are stored with:

• unique name constraint  
• creation timestamp  

### Realm (Local Cache)

Realm is used as a **local caching layer for weather responses**, allowing the application to:

• cache previously fetched weather data  
• improve load performance  
• reduce unnecessary API calls  
• support offline-first behavior

This hybrid persistence strategy demonstrates the ability to integrate **Apple-native and third-party storage solutions** within the same architecture.

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

### UI Tests

The project also includes **end-to-end UI tests using XCTest**, validating critical user interactions and navigation flows.

The UI test suite verifies real user behavior such as:

• Searching for cities  
• Displaying search results  
• Navigating to weather details  
• Saving cities to local storage  
• Deleting saved cities using swipe actions  



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
UIKit  
Swift Concurrency (async/await)  
SwiftData  
Realm  
Combine  
XCTest  
UICollectionView Compositional Layout  
Diffable Data Sources

---

These UIKit components are organized into reusable cells, compositional layouts, and diffable data sources to support scalable and maintainable UI architecture.

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

