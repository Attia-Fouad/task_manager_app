Task Manager App
Overview

This is a Flutter-based Task Manager app that allows users to efficiently manage their tasks. The app implements user authentication, task CRUD operations, pagination, state management, local storage for persistent data, and unit testing. The app follows best practices in Flutter development, including clean code, architecture, and performance optimization.
Features
1. User Authentication

    Users can log in securely with their username and password using the https://dummyjson.com/docs/auth API.
    user name and password for testing
    User name: emilys
    Password: emilyspass

3. Task Management

    Users can view, add, edit, and delete tasks. Task data is managed using the https://dummyjson.com/docs/todos API.

4. Pagination

    Tasks are fetched using pagination. The app uses the endpoint https://dummyjson.com/todos?limit=10&skip=10 to handle large sets of data efficiently.

5. State Management

    The app uses Bloc for managing and updating task data throughout the app.

6. Local Storage

    Tasks are persisted locally using Shared Preferences and SQLite, ensuring they remain accessible even after the app is closed and reopened.

7. Unit Tests

    Comprehensive unit tests are written to cover:
        Task CRUD operations
        State management
        Network requests (mocked responses)

8. Responsive Design
    Using flutter_screenutil 

Setup Instructions

    Clone the repository:https://github.com/Attia-Fouad/task_manager_app.git

git clone 
Install dependencies: Navigate to the project directory and run:

flutter pub get

Run the app: Connect your device and run:

    flutter run

Design Decisions

    State Management: I have used Bloc because it allows easy management of the app's task data and ensures smooth updates across screens.

    Pagination: Implemented pagination to optimize performance when displaying a large number of tasks.

    Local Storage: I opted to use Shared Preferences and SQLite to persist tasks locally so that they remain available even after the app is restarted.

Challenges Faced

1. Unit Testing

This was my first experience with unit testing in Flutter. The main challenge was mocking network responses and setting up tests for asynchronous tasks. Using the flutter_test package, I learned how to mock dependencies and ensure the correctness of task CRUD operations, state updates, and authentication logic.

2. Offline Caching

Implementing offline caching for persistent data was challenging, particularly with syncing local storage (using Shared Preferences&SQLite) with the API. I ensured tasks persisted locally and providing a seamless experience even when offline.

3. Time Management

Balancing the time to implement authentication, task management, pagination, local storage, and unit testing within four days was a challenge. I focused on delivering critical features first and adjusted my approach as I faced issues with testing and caching to ensure a functional and polished solution.


Unit Testing

Unit tests were written using the mockito and bloc_test, with mock responses used for network requests. You can find the test files in the test directory.
Conclusion

This project demonstrates proficiency in Flutter development, state management, data persistence, and writing unit tests. Feel free to reach out if you have any questions or need further clarifications.

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




