class RefreshAuthSessionModel {
  final String accessToken;
  final String refreshToken;

  RefreshAuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshAuthSessionModel.fromJson(Map<String, dynamic> json) {
    return RefreshAuthSessionModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }
}
