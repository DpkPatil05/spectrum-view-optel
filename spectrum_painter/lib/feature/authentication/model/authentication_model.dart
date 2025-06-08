class AuthenticationModel {
  AuthenticationModel({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  AuthenticationModel copyWith({
    String? email,
    String? password,
  }) {
    return AuthenticationModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
