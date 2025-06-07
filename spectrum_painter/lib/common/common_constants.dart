abstract class CommonConstants {
  static final StringConstants strings = StringConstants();

  static final ImageConstants images = ImageConstants();

  static final SharedPreferencesKeyConstants sharedPreferencesKeys =
      SharedPreferencesKeyConstants();

  static final RouteConstants routes = RouteConstants();

  static final NumberConstants numbers = NumberConstants();
}

/// All the strings that will be utilized by the application
class StringConstants {
  final String appName = 'Spectrum painter';

  // Authentication string constants
  final String login = 'login';
  final String logout = 'logout';
  final String signUp = 'sign up';
  final String email = 'email';
  final String enterEmail = 'enter email';
  final String password = 'password';
  final String enterPassword = 'enter password';
  final String forgotPassword = 'forgot password?';
  final String done = 'done';
  final String next = 'next';
  final String emptyEmailValidation = 'enter email';
  final String invalidEmailFormatValidation = 'invalid email format';
  final String emptyPasswordValidation = 'enter password';
  final String emptyEmailAndPasswordFieldValidation = 'enter email & password';
  final String invalidEmailAndPassword = 'invalid email & password';
  final String youHaveBeenLoggedOut = 'you have been logged out!';
  final String profile = 'Profile';
  final String editProfile = 'edit profile';
  final String settings = 'settings';

  // Exception messages
  final String dataTypeNotFound = 'DataType Not Found!';

  // Walkthrough texts
  final String walkthroughIntroHeaderText = 'Welcome to Travel journal';
  final String skip = 'skip';
  final String refreshing = 'refreshing...';

  // Other strings
  final String userName = 'username';
  final String dash = '-';
}

/// All the images that will be used by the application
class ImageConstants {}

/// All the keys that will be used for the SharedPreferences
class SharedPreferencesKeyConstants {
  final String loginKey = 'loginKey';
}

/// App routes
class RouteConstants {
  final String root = '/';
  final String home = 'home';
}

/// All numbers
class NumberConstants {
  final int zero = 0;
}
