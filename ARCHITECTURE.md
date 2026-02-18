# ChildCard Architecture Overview

## 🏗️ MVVM Architecture with Riverpod

```
┌─────────────────────────────────────────────────────────────────┐
│                          PRESENTATION LAYER                      │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐       │
│  │ LoginScreen   │  │ SignUpScreen  │  │  HomeScreen   │       │
│  │               │  │               │  │               │       │
│  │  - UI/Forms   │  │  - UI/Forms   │  │  - Dashboard  │       │
│  │  - Validation │  │  - Validation │  │  - Profile    │       │
│  └───────┬───────┘  └───────┬───────┘  └───────┬───────┘       │
│          │                  │                  │                 │
│          └──────────────────┼──────────────────┘                 │
│                             │                                    │
└─────────────────────────────┼────────────────────────────────────┘
                              │ Riverpod Providers
                              │
┌─────────────────────────────┼────────────────────────────────────┐
│                       VIEWMODEL LAYER                            │
│                 ┌─────────────────────┐                          │
│                 │  AuthViewModel      │                          │
│                 │  (StateNotifier)    │                          │
│                 ├─────────────────────┤                          │
│                 │ State Management:   │                          │
│                 │  ├─ isLoading       │                          │
│                 │  ├─ isAuthenticated │                          │
│                 │  ├─ errorMessage    │                          │
│                 │  └─ successMessage  │                          │
│                 ├─────────────────────┤                          │
│                 │ Methods:            │                          │
│                 │  ├─ signIn()        │                          │
│                 │  ├─ signUp()        │                          │
│                 │  ├─ signOut()       │                          │
│                 │  └─ clearMessages() │                          │
│                 └──────────┬──────────┘                          │
│                            │                                     │
└────────────────────────────┼─────────────────────────────────────┘
                             │
┌────────────────────────────┼─────────────────────────────────────┐
│                      REPOSITORY LAYER                            │
│                 ┌──────────────────────┐                         │
│                 │  AuthRepository      │                         │
│                 ├──────────────────────┤                         │
│                 │ HTTP Client (http)   │                         │
│                 ├──────────────────────┤                         │
│                 │ Methods:             │                         │
│                 │  ├─ signIn()   → API │                         │
│                 │  └─ signUp()   → API │                         │
│                 └──────────┬───────────┘                         │
│                            │                                     │
└────────────────────────────┼─────────────────────────────────────┘
                             │
┌────────────────────────────┼─────────────────────────────────────┐
│                        DATA LAYER                                │
│         ┌──────────────────┴──────────────────┐                 │
│         │                                      │                 │
│  ┌──────▼──────┐                    ┌─────────▼────────┐        │
│  │ Models      │                    │ Services         │        │
│  ├─────────────┤                    ├──────────────────┤        │
│  │ User        │                    │ StorageService   │        │
│  │ LoginReq    │                    │ (SharedPrefs)    │        │
│  │ LoginRes    │                    ├──────────────────┤        │
│  │ SignUpReq   │                    │ ├─ saveToken()   │        │
│  │ SignUpRes   │                    │ ├─ getToken()    │        │
│  └─────────────┘                    │ ├─ saveUser()    │        │
│                                      │ ├─ getUser()     │        │
│                                      │ └─ clearAll()    │        │
│                                      └──────────────────┘        │
└──────────────────────────────────────────────────────────────────┘
                             │
┌────────────────────────────┼─────────────────────────────────────┐
│                       EXTERNAL LAYER                             │
│         ┌──────────────────┴──────────────────┐                 │
│         │                                      │                 │
│  ┌──────▼──────┐                    ┌─────────▼────────┐        │
│  │ REST API    │                    │ Local Storage    │        │
│  ├─────────────┤                    ├──────────────────┤        │
│  │ Base URL:   │                    │ SharedPreferences│        │
│  │ 192.168.    │                    │                  │        │
│  │ 29.25:5001  │                    │ Persisted Data:  │        │
│  ├─────────────┤                    │  ├─ auth_token   │        │
│  │ Endpoints:  │                    │  ├─ user_id      │        │
│  │ /api/signin │                    │  ├─ user_email   │        │
│  │ /api/signup │                    │  └─ user_name    │        │
│  └─────────────┘                    └──────────────────┘        │
└──────────────────────────────────────────────────────────────────┘
```

## 📊 Data Flow

### Sign In Flow

```
User Input (Email/Password)
    ↓
LoginScreen validates form
    ↓
Calls authViewModel.signIn()
    ↓
AuthViewModel sets isLoading = true
    ↓
Calls authRepository.signIn()
    ↓
AuthRepository makes HTTP POST to /api/signin
    ↓
API returns LoginResponse
    ↓
AuthRepository parses JSON to LoginResponse model
    ↓
AuthViewModel receives response
    ↓
If success:
    ├─ Save token to StorageService
    ├─ Save user data to StorageService
    ├─ Set isAuthenticated = true
    └─ Navigate to HomeScreen
If error:
    ├─ Set errorMessage
    └─ Show error SnackBar
```

## 🔄 State Management Pattern

```
┌──────────────┐
│  Provider    │ ← StateNotifierProvider
│  Scope       │
└──────┬───────┘
       │
       ├─ Creates ViewModel instance
       ├─ Injects dependencies (Repository, Services)
       └─ Provides state to Consumers
              │
              ▼
       ┌──────────────┐
       │   Consumer   │ ← Widget that listens
       │   Widget     │
       └──────┬───────┘
              │
              ├─ Reads state: ref.watch()
              ├─ Calls methods: ref.read().notifier.method()
              └─ Rebuilds on state change
```

## 🎯 Key Principles

1. **Separation of Concerns**
   - Views: Only UI rendering
   - ViewModels: Business logic & state
   - Repositories: Data operations
   - Models: Data structures

2. **Dependency Injection**
   - Repositories injected into ViewModels
   - Services injected via Riverpod Providers

3. **Immutability**
   - State changes through copyWith()
   - No direct state mutation

4. **Single Responsibility**
   - Each class has one job
   - Easy to test and maintain

## 📦 File Organization

```
lib/
├── core/               # Core utilities
│   ├── constants/      # App-wide constants
│   └── services/       # Shared services
│
├── data/              # Data layer
│   ├── models/        # Data models
│   └── repositories/  # Data sources
│
├── viewmodels/        # Business logic
│   └── *_viewmodel.dart
│
└── views/             # UI layer
    └── screens/       # Screen widgets
```
