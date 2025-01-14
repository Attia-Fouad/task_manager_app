
class ApiConstants {
  static const baseUrl =
      "https://dummyjson.com/";
  static const login = "auth/login";
  static const currentUserData = "auth/me";
  static getAnotherProfileRequests({required String id}) {
    return "request/user/$id";
  }
}
