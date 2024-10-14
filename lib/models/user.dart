class User {
  final String username;
  final String email;
  final String phoneNumber;

  User(
      {required this.username, required this.email, required this.phoneNumber});

  // Factory constructor to create a User from a JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}
