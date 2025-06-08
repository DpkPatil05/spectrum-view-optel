import 'package:http/http.dart' as http;
import 'package:spectrum_painter/common/common_constants.dart';

class LoginRepository {
  // Private constructor
  LoginRepository._internal();

  // Singleton instance
  static final LoginRepository _instance = LoginRepository._internal();

  // Getter to access the singleton instance
  static LoginRepository get instance => _instance;

  // Instance method
  Future<http.Response?> login(String email, String password) async {
    try {
      var url = Uri.http(StringConstants.baseUrl, StringConstants.loginPath);
      final response = await http.post(
        url,
        body: {'userId': email, 'password': password},
      );
      return response;
    } on http.ClientException catch (e) {
      // Handle specific HTTP client errors
      print('ClientException: ${e.message}');
    } on Exception catch (e) {
      // Handle general exceptions
      print('Exception during login: ${e.toString()}');
    } catch (e) {
      // Catch-all for any other errors
      print('Unexpected error: $e');
    }
    return null;
  }
}
