import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spectrum_painter/common/common_constants.dart';

class MarkAsBoughtRepository {
  // Private constructor
  MarkAsBoughtRepository._internal();

  // Singleton instance
  static final MarkAsBoughtRepository _instance =
      MarkAsBoughtRepository._internal();

  // Getter to access the singleton instance
  static MarkAsBoughtRepository get instance => _instance;

  // Instance method
  Future<http.Response?> markAsBought(String email, String serialNumber) async {
    try {
      var url = Uri.http(StringConstants.baseUrl, StringConstants.consumePath);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': email, 'serialNumber': serialNumber}),
      );
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
