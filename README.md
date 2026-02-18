# ChildCard - Flutter MVVM with Riverpod

A modern Flutter application built with **MVVM architecture** and **Riverpod** state management, featuring authentication screens and REST API integration.

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart          # API URLs and Storage keys
│   └── services/
│       └── storage_service.dart        # SharedPreferences service
│
├── data/
│   ├── models/
│   │   ├── user_model.dart            # User data model
│   │   ├── login_model.dart           # Login request/response models
│   │   └── signup_model.dart          # Signup request/response models
│   └── repositories/
│       └── auth_repository.dart        # Authentication API calls
│
├── viewmodels/
│   └── auth_viewmodel.dart            # Authentication state management
│
├── views/
│   └── screens/
│       ├── login_screen.dart          # Login UI
│       ├── signup_screen.dart         # Signup UI
│       └── home_screen.dart           # Home UI
│
└── main.dart                          # App entry point
```

## 🏗️ Architecture: MVVM (Model-View-ViewModel)

### **Model** (`data/models/`)

- Plain Dart classes representing data structures
- JSON serialization/deserialization
- Immutable data with `copyWith` methods

### **View** (`views/screens/`)

- UI components built with Flutter widgets
- Consumes state from ViewModels
- No business logic - only UI rendering

### **ViewModel** (`viewmodels/`)

- Manages UI state using Riverpod's `StateNotifier`
- Handles business logic
- Communicates with repositories
- Exposes state to Views

### **Repository** (`data/repositories/`)

- Handles data operations (API calls, database, etc.)
- Abstracts data sources from ViewModels
- Returns domain models

## 🔧 Key Technologies

- **State Management**: `flutter_riverpod ^2.4.10`
- **HTTP Client**: `http ^1.2.0`
- **Local Storage**: `shared_preferences ^2.2.2`
- **JSON Serialization**: `json_annotation ^4.8.1`

## 🔌 API Configuration

**Base URL**: `http://192.168.29.25:5001`

### Endpoints

- **Sign In**: `POST /api/signin`

  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```

- **Sign Up**: `POST /api/signup`

  ```json
  {
    "name": "John Doe",
    "email": "user@example.com",
    "password": "password123"
  }
  ```

## 🎨 Features

✅ **Login Screen**

- Email & password authentication
- Form validation
- Password visibility toggle
- Loading states
- Error handling

✅ **Signup Screen**

- User registration with name, email, password
- Password confirmation
- Form validation
- Error handling

✅ **Home Screen**

- User profile display
- Welcome card with gradient
- Quick action cards
- Logout functionality

## 🚀 Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run the App

```bash
flutter run
```

## 📦 Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^2.4.10
  http: ^1.2.0
  shared_preferences: ^2.2.2
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

## 🔐 Authentication Flow

1. **App Launch** → Check if user is logged in (token exists)
   - If YES → Navigate to **Home Screen**
   - If NO → Navigate to **Login Screen**

2. **Login/Signup** → API call → Save token & user data → Navigate to **Home Screen**

3. **Logout** → Clear all stored data → Navigate to **Login Screen**

## 💾 Local Storage

User data is persisted using `SharedPreferences`:

- `auth_token`: JWT or authentication token
- `user_id`: User's unique identifier
- `user_email`: User's email address
- `user_name`: User's full name

## 🎯 Riverpod Providers

### `authRepositoryProvider`

Provides instance of `AuthRepository` for API calls

### `storageServiceProvider`

Provides instance of `StorageService` for local storage

### `authViewModelProvider`

Provides `AuthViewModel` state and notifier for authentication

## 📱 Screen Navigation

- **Login** ↔️ **Signup**: Simple push/pop navigation
- **Login/Signup** → **Home**: Replace navigation (no back)
- **Home** → **Login** (Logout): Clear stack and replace

## 🎨 UI Highlights

- **Material Design 3** with custom theme
- **Gradient cards** for visual appeal
- **Rounded corners** (12px border radius)
- **Elevation & shadows** for depth
- **Loading indicators** during API calls
- **Error/Success snackbars** for feedback

## 🔍 Code Quality

- ✅ Separation of Concerns (MVVM)
- ✅ State Management with Riverpod
- ✅ Dependency Injection
- ✅ Error Handling
- ✅ Form Validation
- ✅ Type Safety
- ✅ Immutable State

## 📝 Notes

- Update the base URL in `lib/core/constants/app_constants.dart` to match your backend
- Backend should return JWT token and user object on successful authentication
- Expected API response format:

  ```json
  {
    "success": true,
    "message": "Login successful",
    "data": {
      "token": "jwt_token_here",
      "user": {
        "user_id": "123",
        "email": "user@example.com",
        "name": "John Doe"
      }
    }
  }
  ```

## 🛠️ Future Enhancements

- [ ] Password reset functionality
- [ ] Profile editing
- [ ] Token refresh mechanism
- [ ] Biometric authentication
- [ ] Dark mode support
- [ ] Multi-language support

---

**Built with ❤️ using Flutter & Riverpod**
