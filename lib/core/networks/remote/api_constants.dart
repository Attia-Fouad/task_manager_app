class ApiConstants {
  static const baseUrl = "https://dummyjson.com/";
  static const login = "auth/login";
  static const currentUserData = "auth/me";
  static const refreshAuthSession = "auth/refresh";
  static const addTask = "todos/add";

  static getAllUserTasks({required num userId}) {
    return "todos/user/$userId";
  }
  static task({required num taskId}) {
    return "todos/$taskId";
  }
}
