# 🔐 Auth Feature - JobLink App

This module handles the full authentication flow for the **JobLink** application using Flutter with **Clean Architecture + MVVM** structure and **Cubit** for state management.

---

## 📦 Features Implemented

### ✅ Register
- Full user registration form (name, email, password)
- Form validation
- Sends registration data to API
- Handles response, saves token locally
- Displays server error messages clearly
- Navigates to Home after successful registration

### ✅ Login
- Fully validated login form
- Sends credentials to backend
- Saves user token on success
- Displays appropriate error on failure
- Navigates to Home on success

---

## 🧠 Architecture

- **State Management:** Cubit
- **Architecture Pattern:** MVVM + Clean Architecture
- **Networking:** Dio
- **Routing:** GoRouter
- **Local Storage:** SharedPreferences via AppPreferences

---

## 🔐 Token Handling

- After successful login/register, the received token is saved securely using `AppPreferences`.
- The token is used later for authenticated API requests (e.g., Jobs listing).

---

## ✅ Dependencies Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [dio](https://pub.dev/packages/dio)
- [go_router](https://pub.dev/packages/go_router)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
