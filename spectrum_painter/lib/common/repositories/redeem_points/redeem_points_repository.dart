import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spectrum_painter/common/common_constants.dart';

class RedeemPointsRepository {
  // Private constructor
  RedeemPointsRepository._internal();

  // Singleton instance
  static final RedeemPointsRepository _instance =
      RedeemPointsRepository._internal();

  // Getter to access the singleton instance
  static RedeemPointsRepository get instance => _instance;

  // Instance method
  Future<http.Response?> redeemPoints(String email, String points) async {
    try {
      final String redeemPointsApiPath =
          '/verify/users/$email/commission/redeem';
      var url = Uri.http(StringConstants.baseUrl, redeemPointsApiPath);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pointsToRedeem': points}),
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
