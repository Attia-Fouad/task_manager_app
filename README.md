# Task Manager App

## Overview

This is a Flutter-based Task Manager app that allows users to efficiently manage their tasks. The app implements user authentication, task CRUD operations, pagination, state management, local storage for persistent data, and unit testing. The app follows best practices in Flutter development, including clean code, architecture, and performance optimization.

## Features

### 1. User Authentication
- Users can log in securely with their username and password using the [DummyJSON Auth API](https://dummyjson.com/docs/auth).
- **Username:** emilys  
  **Password:** emilyspass

### 2. Task Management
- Users can view, add, edit, and delete tasks. Task data is managed using the [DummyJSON Todos API](https://dummyjson.com/docs/todos).

### 3. Pagination
- Tasks are fetched using pagination. The app uses the endpoint `https://dummyjson.com/todos?limit=10&skip=10` to handle large sets of data efficiently.

### 4. State Management
- The app uses **Bloc** for managing and updating task data throughout the app.

### 5. Local Storage
- Tasks are persisted locally using **Shared Preferences** and **SQLite**, ensuring they remain accessible even after the app is closed and reopened.

### 6. Unit Tests
Comprehensive unit tests are written to cover:
- Task CRUD operations
- State management
- Network requests (mocked responses)

### 7. Responsive Design
- Implemented using the `flutter_screenutil` package to ensure the app is responsive on various screen sizes.

### 8. Project Structure
```plaintext
├───lib
│   ├───core
│   │   ├───app_router
│   │   ├───app_strings
│   │   ├───bloc_helper
│   │   ├───networks
│   │   │   ├───local
│   │   │   └───remote
│   │   ├───services
│   │   └───styles
│   ├───generated
│   ├───models
│   ├───repositories
│   │   ├───auth_repo
│   │   └───tasks_repo
│   └───view
│       ├───app_layout
│       │   └───cubit
│       ├───login
│       │   └───cubit
│       ├───onboarding
│       │   └───widgets
│       ├───reusable_widgets
│       ├───splash
│       └───tasks
│           ├───cubit
│           └───widgets
│               ├───mobile_widgets
│               └───tablet_widgets
```

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Attia-Fouad/task_manager_app.git
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Design Decisions

### State Management
- **Bloc** was used because it allows easy management of the app's task data and ensures smooth updates across screens.

### Pagination
- Implemented pagination to optimize performance when displaying a large number of tasks.

### Local Storage
- Used **Shared Preferences** and **SQLite** to persist tasks locally, ensuring they remain available even after the app is restarted.

## Challenges Faced

### 1. Unit Testing
- This was my first experience with unit testing in Flutter. The main challenge was mocking network responses and setting up tests for asynchronous tasks. Using the `flutter_test` package, I learned how to mock dependencies and ensure the correctness of task CRUD operations, state updates, and authentication logic.

### 2. Offline Caching
- Implementing offline caching for persistent data was challenging, particularly with syncing local storage (using Shared Preferences and SQLite) with the API. I ensured tasks persisted locally and provided a seamless experience even when offline.

### 3. Time Management
- Balancing the time to implement authentication, task management, pagination, local storage, and unit testing within four days was a challenge. I focused on delivering critical features first and adjusted my approach as I faced issues with testing and caching to ensure a functional and polished solution.

## Unit Testing

- Unit tests were written using the `mockito` and `bloc_test` packages, with mock responses used for network requests. You can find the test files in the `test` directory.

## Conclusion

This project demonstrates proficiency in Flutter development, state management, data persistence, and writing unit tests. Feel free to reach out if you have any questions or need further clarifications.

## Screenshots

<p align="center">
      <img src="https://github.com/user-attachments/assets/12e7b51b-898d-4f5d-9461-3bf84cdee729" width="30%" />
  <img src="https://github.com/user-attachments/assets/25a3395a-943e-40e6-8024-793e1a5ed231" width="30%" />
  <img src="https://github.com/user-attachments/assets/659d5d9f-a613-4ccd-b8ce-2f4030b50285" width="30%" />
</p>

<p align="center">
      <img src="https://github.com/user-attachments/assets/c3a11e8b-a8c3-44b5-8b51-54991be76657" width="30%" />
  <img src="https://github.com/user-attachments/assets/8135cd6b-e417-43ed-9f70-e45548ac54a6" width="30%" />
  <img src="https://github.com/user-attachments/assets/25081dcd-50aa-470d-8761-7206a5d70de6" width="30%" />
</p>



