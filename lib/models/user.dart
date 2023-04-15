class User {
  String? id;
  String fullName;
  String email;
  String password;
  String? token;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User: { _id: $id, fullName: $fullName, email: $email, password: $password, token: $token }';
  }
}
