````md
# Taghyeer Flutter Assignment

A production-ready Flutter application built for the **Flutter Developer Technical Assignment** of **Taghyeer Technologies**.

This project showcases mid-level Flutter development practices with a strong focus on:

- Clean Architecture
- Bloc State Management
- API Integration
- Pagination
- Login & Session Handling
- Local Caching
- Persistent Theme Management
- Bottom Navigation
- Error Handling
- Clean UI Implementation

---

## Overview

The application is built using the **DummyJSON Open API** and includes the following core modules:

- **User Authentication**
- **Products Listing with Pagination**
- **Posts Listing with Pagination**
- **Settings Screen**
- **Light/Dark Theme Switching**
- **Persistent User Session**
- **Logout Functionality**

---

## Features

### User Authentication
- Login using DummyJSON authentication API
- User session stored locally
- Auto-login after app restart if session exists
- Secure logout by clearing local session

### Bottom Navigation
The application contains 3 main tabs:

1. **Products**
2. **Posts**
3. **Settings**

### Products Module
- Product image thumbnail
- Product title
- Product price
- Infinite pagination using `limit` and `skip`
- Loading state
- Pagination loading indicator
- Error state with retry
- Empty state
- Product detail screen

### Posts Module
- Post title
- Short body preview
- Pagination using `limit` and `skip`
- Loading state
- Pagination loading indicator
- Error state with retry
- Empty state
- Post detail screen

### Settings Module
- Cached user information
- Profile image
- Username
- Full name
- Email
- Theme switching
- Persistent light/dark mode
- Logout option

---

## Architecture

This project follows **Clean Architecture** for scalability, maintainability, and separation of concerns.

### Folder Structure

```text
lib/
├── app.dart
├── main.dart
├── core
│   ├── constants
│   ├── di
│   ├── error
│   ├── network
│   └── utils
├── data
│   ├── datasources
│   ├── models
│   └── repositories
├── domain
│   ├── entities
│   ├── repositories
│   └── usecases
└── presentation
    ├── cubits
    ├── pages
    └── widgets
````

### Architecture Layers

#### Core

Common app-wide utilities and shared components:

* API constants
* Dependency injection
* Network configuration
* Error models
* Result wrapper

#### Data Layer

Responsible for:

* Remote API calls
* Local storage access
* JSON models
* Repository implementations

#### Domain Layer

Contains:

* Business entities
* Repository contracts
* Use cases

#### Presentation Layer

Contains:

* UI screens
* Bloc/Cubit state management
* Reusable widgets

---

## State Management

This project uses **Flutter Bloc (Cubit)** for state management.

State is managed for:

* Authentication
* Theme mode
* Product pagination
* Post pagination

---

## Tech Stack

* **Flutter**
* **Dart**
* **Bloc / Cubit**
* **Dio**
* **SharedPreferences**
* **GoRouter**
* **GetIt**

---

## API Endpoints

### Login

**POST**
`https://dummyjson.com/auth/login`

#### Request Body

```json
{
  "username": "emilys",
  "password": "emilyspass",
  "expiresInMins": 30
}
```

### Products

**GET**
`https://dummyjson.com/products?limit=10&skip=0`

### Posts

**GET**
`https://dummyjson.com/posts?limit=10&skip=0`

---

## Demo Credentials

Use the following credentials to test login:

```text
Username: emilys
Password: emilyspass
```

---

## Implemented Requirements

* Clean Architecture
* Bloc State Management
* API Integration
* Pagination
* Login and Session Handling
* Local Caching
* Bottom Navigation
* Error Handling
* Theme Management
* UI/UX Implementation

---

## Error Handling

The app gracefully handles the following cases:

* No internet connection
* Slow network response
* API failure
* Empty response
* Pagination failure

Every state is presented with meaningful UI feedback and retry options where applicable.

---

## Local Storage

Local storage is used for:

* Caching logged-in user data
* Persisting selected theme mode

Storage solution used:

* **SharedPreferences**

---

## How to Run

### 1. Get dependencies

```bash
flutter pub get
```

### 2. Run the project

```bash
flutter run
```

### 3. Build APK

```bash
flutter build apk
```

---

## Why This Project Stands Out

* Follows production-style folder structure
* Uses scalable Clean Architecture
* Maintains clear separation between UI, business logic, and data
* Supports persistent login and theme mode
* Implements pagination properly
* Includes reusable and maintainable code structure

---

## Future Improvements

Potential future enhancements:

* Offline caching for products and posts
* Pull-to-refresh improvements
* Search and filtering
* Unit testing
* Widget testing
* Better loading placeholders
* Token refresh handling
* Improved animations and transitions

---

## Author

**Partha Baral**

Flutter Developer Technical Assignment Submission
**Taghyeer Technologies**

```
```
