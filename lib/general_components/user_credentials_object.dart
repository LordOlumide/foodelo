class UserCredentials {
  final String token;
  final String userId;

  UserCredentials({
    required this.token,
    required this.userId,
  });

  @override
  String toString() {
    return 'User credentials: {\ntoken: $token, \nuserId: $userId\n}';
  }
}
