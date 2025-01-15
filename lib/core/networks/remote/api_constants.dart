class ApiConstants {
  static const baseUrl = "https://dummyjson.com/";
  static const login = "auth/login";
  static const currentUserData = "auth/me";

  static getAllUserTasks({required num userId}) {
    return "todos/user/$userId";
  }
  static task({required num taskId}) {
    return "todos/$taskId";
  }
}
