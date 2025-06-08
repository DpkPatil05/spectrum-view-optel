import 'package:http/http.dart' as http;
import 'package:spectrum_painter/common/common_constants.dart';

class VerifyProductRepository {
  // Private constructor
  VerifyProductRepository._internal();

  // Singleton instance
  static final VerifyProductRepository _instance =
      VerifyProductRepository._internal();

  // Getter to access the singleton instance
  static VerifyProductRepository get instance => _instance;

  // Instance method
  Future<http.Response?> verifyProduct(String serialNumber) async {
    try {
      final String verifyProductApiPath =
          '/verify/serial-numbers/$serialNumber';
      var url = Uri.http(StringConstants.baseUrl, verifyProductApiPath);
      final response = await http.get(url);
      return response;
    } on http.ClientException catch (e) {
      // Handle specific HTTP client errors
      print('ClientException: ${e.message}');
    } on Exception catch (e) {
      // Handle general exceptions
      print('Exception during redeem: ${e.toString()}');
    } catch (e) {
      // Catch-all for any other errors
      print('Unexpected error: $e');
    }
    return null;
  }
}
