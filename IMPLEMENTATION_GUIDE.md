# 🎨 ChildCard - Implementation Guide

## 📱 Quick Start Commands

```bash
# Navigate to project
cd /Users/techment/projects/automation/childcard

# Install dependencies
flutter pub get

# Check for issues (should show: No issues found!)
flutter analyze

# Run the app
flutter run
```

## 🗂️ Complete File Structure

```
childcard/
├── lib/
│   ├── core/                              # Core utilities
│   │   ├── constants/
│   │   │   └── app_constants.dart         # API URLs & keys (83 bytes)
│   │   └── services/
│   │       └── storage_service.dart       # Local storage (1.8 KB)
│   │
│   ├── data/                              # Data layer
│   │   ├── models/
│   │   │   ├── user_model.dart            # User model (896 bytes)
│   │   │   ├── login_model.dart           # Login models (1.3 KB)
│   │   │   └── signup_model.dart          # Signup models (1.4 KB)
│   │   └── repositories/
│   │       └── auth_repository.dart       # API repository (2.1 KB)
│   │
│   ├── viewmodels/                        # Business logic
│   │   └── auth_viewmodel.dart            # Auth ViewModel (4.0 KB)
│   │
│   ├── views/                             # UI layer
│   │   └── screens/
│   │       ├── login_screen.dart          # Login UI (8.2 KB)
│   │       ├── signup_screen.dart         # Signup UI (10.5 KB)
│   │       └── home_screen.dart           # Home UI (12.0 KB)
│   │
│   └── main.dart                          # App entry (2.6 KB)
│
├── README.md                              # Project documentation
├── ARCHITECTURE.md                        # Architecture details
└── SETUP_COMPLETE.md                     # Setup summary
```

**Total: 11 Dart files | Clean MVVM structure**

## 🔑 Key Files Explanation

### 1. **main.dart** - Application Entry Point

- Initializes `ProviderScope` for Riverpod
- Sets up app theme (Material Design 3)
- Checks authentication status
- Routes to Login or Home screen

### 2. **app_constants.dart** - Configuration

```dart
Base URL: http://192.168.29.25:5001
Sign In: /api/signin
Sign Up: /api/signup
Storage Keys: auth_token, user_id, user_email, user_name
```

### 3. **storage_service.dart** - Local Data Persistence

- Wrapper around SharedPreferences
- Manages user session data
- Token storage and retrieval

### 4. **Models** (user, login, signup)

- Data structures for API communication
- JSON serialization/deserialization
- Immutable data with copyWith methods

### 5. **auth_repository.dart** - API Communication

- HTTP POST requests to backend
- JSON parsing
- Error handling

### 6. **auth_viewmodel.dart** - State Management

```dart
State: isLoading, isAuthenticated, errorMessage, successMessage
Methods: signIn(), signUp(), signOut(), clearMessages()
Providers: authRepositoryProvider, authViewModelProvider
```

### 7. **Screens** (Login, Signup, Home)

- UI components using Flutter widgets
- Form validation
- Riverpod consumers
- Loading states and error handling

## 🔄 Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    USER INTERACTION                          │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  VIEW (Screens)                                              │
│  • Captures user input                                       │
│  • Validates forms                                           │
│  • Displays loading/error states                            │
└────────────────────────┬────────────────────────────────────┘
                         │ ref.read().notifier.method()
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  VIEWMODEL (StateNotifier)                                   │
│  • Receives user actions                                     │
│  • Updates state (isLoading = true)                          │
│  • Calls repository methods                                  │
└────────────────────────┬────────────────────────────────────┘
                         │ repository.signIn()
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  REPOSITORY                                                  │
│  • Makes HTTP requests                                       │
│  • Parses JSON responses                                     │
│  • Returns domain models                                     │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP POST
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  REST API (Backend)                                          │
│  • Validates credentials                                     │
│  • Returns JWT token + user data                            │
└────────────────────────┬────────────────────────────────────┘
                         │ Response
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  VIEWMODEL (Updates State)                                   │
│  • Parses response                                           │
│  • Saves to StorageService                                   │
│  • Sets isAuthenticated = true                              │
└────────────────────────┬────────────────────────────────────┘
                         │ State change notification
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  VIEW (Rebuilds)                                             │
│  • Shows success message                                     │
│  • Navigates to Home screen                                  │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 MVVM Architecture Explained

### **M - Model** (data/models/)

**What**: Plain data classes
**Responsibility**: Represent data structure
**Example**: User, LoginRequest, LoginResponse

```dart
class User {
  final String userId;
  final String email;
  final String name;
  
  // fromJson, toJson, copyWith
}
```

### **V - View** (views/screens/)

**What**: Flutter widgets (UI)
**Responsibility**: Display data and capture input
**Example**: LoginScreen, SignUpScreen, HomeScreen

```dart
class LoginScreen extends ConsumerWidget {
  // UI only - no business logic
  // Uses ref.watch() to listen to state
  // Uses ref.read() to trigger actions
}
```

### **VM - ViewModel** (viewmodels/)

**What**: Business logic layer
**Responsibility**: Manage state and coordinate data flow
**Example**: AuthViewModel

```dart
class AuthViewModel extends StateNotifier<AuthState> {
  // Business logic
  // Calls repository
  // Updates state
  // No UI knowledge
}
```

### **Repository** (data/repositories/)

**What**: Data source abstraction
**Responsibility**: Fetch/Send data from/to API
**Example**: AuthRepository

```dart
class AuthRepository {
  // API calls
  // JSON parsing
  // Returns models
  // No state management
}
```

## 📊 State Management Flow

```
User Action (Button Click)
    ↓
View calls: ref.read(authViewModelProvider.notifier).signIn(email, password)
    ↓
ViewModel method executes:
    1. state = state.copyWith(isLoading: true)
    2. response = await repository.signIn(request)
    3. if (success): save data + state = authenticated
    4. if (error): state = error message
    ↓
View listens: ref.watch(authViewModelProvider)
    ↓
View rebuilds with new state
    ↓
UI updates (loading spinner → success/error)
```

## 🔐 Authentication Flow Details

### Sign Up Process

```
1. User fills form (name, email, password)
2. Form validation runs
3. SignUpScreen → authViewModel.signUp()
4. ViewModel → authRepository.signUp()
5. Repository → POST /api/signup
6. API validates and creates user
7. API returns { token, user }
8. Repository parses response → SignUpResponse
9. ViewModel receives response
10. If success:
    - storageService.saveToken(token)
    - storageService.saveUser(user)
    - state.isAuthenticated = true
11. View receives state change
12. Navigate to HomeScreen
```

### Sign In Process

```
Similar to Sign Up, but:
- POST /api/signin
- Only email + password (no name)
```

### Auto-Login on App Start

```
1. main() runs
2. StorageService.init()
3. Check: storageService.getToken()
4. If token exists:
   - Navigate to HomeScreen
5. If no token:
   - Navigate to LoginScreen
```

## 📱 Screen Details

### Login Screen Features

- ✅ Email input field
- ✅ Password input field with visibility toggle
- ✅ Form validation
- ✅ Loading indicator during login
- ✅ Error snackbar on failure
- ✅ Navigation to Signup screen
- ✅ Auto-redirect to Home on success

### Signup Screen Features

- ✅ Name input field
- ✅ Email input field
- ✅ Password input field with visibility toggle
- ✅ Confirm password field
- ✅ Password matching validation
- ✅ Loading indicator during signup
- ✅ Error snackbar on failure
- ✅ Auto-redirect to Home on success

### Home Screen Features

- ✅ Welcome card with user info
- ✅ Gradient background
- ✅ Profile information display
- ✅ Quick action cards
- ✅ Logout button with confirmation
- ✅ Beautiful Material Design 3 UI

## 🧪 Testing the App

### Test Scenario 1: New User Signup

```
1. Launch app → Should show Login screen
2. Click "Sign Up"
3. Fill: Name="John Doe", Email="john@test.com", Password="test123"
4. Confirm Password="test123"
5. Click "Sign Up"
6. Expected: Success → Navigate to Home
7. Expected: See "Welcome Back! John Doe"
```

### Test Scenario 2: Returning User Login

```
1. Launch app → Should show Login screen
2. Fill: Email="john@test.com", Password="test123"
3. Click "Sign In"
4. Expected: Success → Navigate to Home
5. Expected: Profile shows correct email and name
```

### Test Scenario 3: Auto-Login

```
1. Close the app completely
2. Relaunch the app
3. Expected: Automatically navigate to Home (no login required)
```

### Test Scenario 4: Logout

```
1. On Home screen, click logout icon
2. Confirmation dialog appears
3. Click "Logout"
4. Expected: Navigate back to Login screen
5. Expected: Session data cleared
```

## 🛠️ Customization Guide

### Change Theme Colors

Edit `lib/main.dart`:

```dart
theme: ThemeData(
  primarySwatch: Colors.purple,  // Change this
  primaryColor: Colors.purple,   // And this
  ...
)
```

### Change API URL

Edit `lib/core/constants/app_constants.dart`:

```dart
static const String baseUrl = 'https://your-api.com';
```

### Add New Screens

1. Create file in `lib/views/screens/new_screen.dart`
2. Use ConsumerWidget or ConsumerStatefulWidget
3. Access state with ref.watch()
4. Call methods with ref.read()

### Add New State

1. Add property to AuthState in auth_viewmodel.dart
2. Update copyWith method
3. Update state in ViewModel methods
4. Access in views with ref.watch()

## 📚 Riverpod Providers Reference

```dart
// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Storage Service Provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Auth ViewModel Provider
final authViewModelProvider = 
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.watch(authRepositoryProvider),
    ref.watch(storageServiceProvider),
  );
});
```

## 🎓 Learning Resources

- **Riverpod**: <https://riverpod.dev/>
- **Flutter MVVM**: <https://flutter.dev/docs/development/data-and-backend>
- **HTTP Package**: <https://pub.dev/packages/http>
- **SharedPreferences**: <https://pub.dev/packages/shared_preferences>

## ✅ Checklist

- [x] MVVM architecture implemented
- [x] Riverpod state management
- [x] Login screen with validation
- [x] Signup screen with validation
- [x] Home screen with profile
- [x] REST API integration
- [x] Session persistence
- [x] Auto-login functionality
- [x] Error handling
- [x] Loading states
- [x] Material Design 3 UI
- [x] Clean code structure
- [x] No analysis errors
- [x] Comprehensive documentation

---

**🎉 Everything is ready! Start coding!**
