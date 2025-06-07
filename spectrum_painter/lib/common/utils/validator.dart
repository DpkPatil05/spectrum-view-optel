import 'package:spectrum_painter/common/extensions/string_extensions.dart';

import '../../feature/authentication/model/authentication_model.dart';
import '../common_constants.dart';

class Validator {
  Validator._();

  static String? validateCredentials(AuthenticationModel userModel) {
    String? emailValidation = _validateEmail(userModel.email);
    String? passwordValidation = _validatePassword(userModel.password);
    if (emailValidation != null && passwordValidation != null) {
      return CommonConstants.strings.invalidEmailAndPassword;
    } else if (emailValidation != null) {
      return emailValidation;
    } else if (passwordValidation != null) {
      return passwordValidation;
    }
    return null;
  }

  static String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return CommonConstants.strings.emptyEmailValidation;
    } else if (!email.isValidEmail) {
      return CommonConstants.strings.invalidEmailFormatValidation;
    }
    return null;
  }

  static String? _validatePassword(String? password) {
    if (password != null && password.isEmpty) {
      return CommonConstants.strings.emptyPasswordValidation;
    }
    return null;
  }
}
