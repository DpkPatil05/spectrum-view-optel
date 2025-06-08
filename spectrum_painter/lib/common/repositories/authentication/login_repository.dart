class LoginRepository {
  // Private constructor
  LoginRepository._internal();

  // Singleton instance
  static final LoginRepository _instance = LoginRepository._internal();

  // Getter to access the singleton instance
  static LoginRepository get instance => _instance;

  // Instance method
  Future<String?> login(String email, String password) async {
    String? response;
    try {
      // TODO: implement actual login logic
      print('Logging in....');
    } on Exception catch (e) {
      response = 'Exception: ${e.toString()}';
    } catch (e) {
      response = 'There was some problem logging in, please retry';
    }
    return response;
  }
}
