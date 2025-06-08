import 'dart:ui';

/// All the strings that will be utilized by the application
class StringConstants {
  StringConstants._();

  static const appName = 'Spectrum painter';
  static const String fontPrompt = 'Prompt';

  static const baseUrl = '10.0.2.2:3000';
  static const loginPath = '/auth/login';
  static const consumePath = '/verify/consume';

  // Authentication string constants
  static const login = 'login';
  static const logout = 'logout';
  static const loading = 'loading';
  static const failed = 'failed';
  static const success = 'success';
  static const signUp = 'sign up';
  static const email = 'email';
  static const enterEmail = 'enter email';
  static const password = 'password';
  static const enterPassword = 'enter password';
  static const forgotPassword = 'forgot password?';
  static const done = 'done';
  static const next = 'next';
  static const emptyEmailValidation = 'enter email';
  static const invalidEmailFormatValidation = 'invalid email format';
  static const emptyPasswordValidation = 'enter password';
  static const emptyEmailAndPasswordFieldValidation = 'enter email & password';
  static const invalidEmailAndPassword = 'invalid email & password';
  static const youHaveBeenLoggedOut = 'you have been logged out!';
  static const profile = 'Profile';
  static const editProfile = 'edit profile';
  static const settings = 'settings';

  // Exception messages
  static const dataTypeNotFound = 'DataType Not Found!';

  // Walkthrough texts
  static const walkthroughIntroHeaderText = 'Welcome to Travel journal';
  static const skip = 'skip';
  static const refreshing = 'refreshing...';

  // Other strings
  static const userName = 'username';
  static const dash = '-';
}

/// All the images that will be used by the application
class ImageConstants {}

/// All the keys that will be used for the SharedPreferences
class SharedPreferencesKeyConstants {
  static const loginKey = 'loginKey';
  static const userIdKey = 'userIdKey';
}

/// App routes
class RouteConstants {
  RouteConstants._();

  static const root = '/';
  static const home = 'home';
  static const verify = 'verify';
  static const markBought = 'mark-bought';
  static const redeem = 'redeem';
}

/// All the colors used across the application
class ColorConstants {
  ColorConstants._();

  // --- Primary Brand Palette ---
  static const Color primary = Color(
    0xFF0D1117,
  ); // Deep navy black - modern dark base
  static const Color secondary = Color(
    0xFF161B22,
  ); // Slightly lighter dark - contrast for cards
  static const Color tertiary = Color(
    0xFF2A2F3A,
  ); // Mid-dark slate for surfaces
  static const Color accent = Color(
    0xFF58A6FF,
  ); // Soft vibrant blue for links/CTAs

  // --- Neutrals & Backgrounds ---
  static const Color primaryWhite = Color(0xFFF5F5F7); // Gentle near-white
  static const Color lightGray = Color(
    0xFFE5E7EB,
  ); // For dividers, borders, input backgrounds

  // --- Text Colors ---
  static const Color primaryTextColor = Color(
    0xFFEDEDED,
  ); // Bright neutral for dark backgrounds
  static const Color secondaryTextColor = Color(
    0xFFB4B4BD,
  ); // Slate black for light mode

  // --- Transparencies & Depth ---
  static const Color primaryTransparent = Color(0xCC0D1117); // 80% opaque
  static const Color primaryDark = Color(0xFF090B12); // For modals, shadows
  static const Color primaryDarkTransparent = Color(0x99090B12); // 60% opaque

  // --- Status Colors ---
  static const Color success = Color(
    0xFF22C55E,
  ); // Bright success green (like Tailwind's green-500)
  static const Color error = Color(
    0xFFEF4444,
  ); // Clean red (like Tailwind's red-500)

  // --- Utility Colors ---
  static const Color buttonDisabledColor = Color(
    0xFF4B5563,
  ); // Gray-600 (for disabled state)
  static const Color golden = Color(
    0xFFFACC15,
  ); // Amber-400 — for awards or highlights
  static const Color red = Color(0xFFF87171); // Soft red (less harsh)
  static const Color lightGreen = Color(0xFF34D399); // Mint green

  // --- Miscellaneous ---
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color navyBlue = Color(0xFF0A2540); // True dark navy
  static const Color barrierBlack = Color(0xDD000000); // 87% black for overlays
}

/// All the spacing constants used by the app
class SpaceConstants {
  SpaceConstants._();

  // Flex constants
  static const int flex2 = 2;
  static const int flex3 = 3;
  static const int flex4 = 4;
  static const int flex5 = 5;
  static const int flex6 = 6;
  static const int flex7 = 7;
  static const int flex8 = 8;
  static const int flex9 = 9;
  static const int flex10 = 10;
  static const int flex12 = 12;
  static const int flex14 = 14;

  // Space Constants
  static const double zero = 0.0;
  static const double space1 = 1.0;
  static const double space2 = 2.0;
  static const double space3 = 3.0;
  static const double space4 = 4.0;
  static const double space5 = 5.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space11 = 11.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space30 = 30.0;
  static const double space34 = 34.0;
  static const double space38 = 38.0;
  static const double space40 = 40.0;
  static const double space50 = 50.0;
  static const double space56 = 56.0;
  static const double space60 = 60.0;
  static const double space80 = 80.0;
  static const double space100 = 100.0;
  static const double space110 = 110.0;
  static const double space120 = 120.0;
  static const double space150 = 150.0;

  // Default Constants
  static const double defaultAspectRatio = 13 / 9;
  static const int defaultDelay = 4;
  static const int defaultAnimationDelay = 400;
  static const int defaultGridCrossAxisCount = 1;
  static const double defaultMinimumBottomSheetSize = 0.25;
  static const double defaultMaxBottomSheetSize = 0.95;
  static const double defaultCornerRadius = 23.0;
  static const double defaultButtonElevation = 5.0;
  static const double defaultMargin = 8.0;

  // Font Sizes
  static const double defaultFontSize = 16.0;
  static const double defaultTitleFontSize = 20.0;
  static const double headerFontSize = 28.0;
  static const double profileTextFontSize = 10.0;
  static const double defaultAppBarFontSize = 24.0;

  // Button constants
  static const double minimumButtonHeight = 50.0;
  static const double minimumButtonWidth = 160.0;
  static const double roundedButtonHeight = 70.0;
  static const double roundedButtonWidth = 70.0;
  static const double roundedButtonRadius = 40.0;
  static const double roundedButtonPaddingLeft = 10.0;
  static const double buttonBorderThickness = 1.5;
  static const double roundArrowButtonDxOffset = 45.0;
  static const double roundArrowButtonDyOffset = 62.0;
  static const double pageIndicatorsStrokeWidth = 2.0;

  // Miscellaneous constants
  static const int primaryBottomNavBarDefaultIndex = 0;
  static const double progressLoaderThickness = 6.0;

  static const double initialBottomSheetSize = 0.5;
  static const double gradientStart = 0.6;
  static const double opacityTen = 0.1;
  static const double opacityTwentyFive = 0.25;
  static const double opacityEighty = 0.8;
  static const double opacityNinety = 0.9;
  static const double cardViewContainerHeightDivider = 1.35;
}
