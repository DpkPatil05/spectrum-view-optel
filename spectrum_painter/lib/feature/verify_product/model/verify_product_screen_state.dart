class VerifyProductScreenState {
  VerifyProductScreenState({
    this.success,
    this.isVerified,
    this.isLoading = false,
    this.errorText = '',
  });

  final bool isLoading;
  final String errorText;
  final bool? success;
  final bool? isVerified;

  static VerifyProductScreenState get defaultState => VerifyProductScreenState(
    isLoading: false,
    success: null,
    isVerified: null,
    errorText: '',
  );

  VerifyProductScreenState copyWith({
    bool? isLoading,
    bool? success,
    bool? isVerified,
    String? errorText,
  }) => VerifyProductScreenState(
    isLoading: isLoading ?? this.isLoading,
    success: success ?? this.success,
    isVerified: isVerified ?? this.isVerified,
    errorText: errorText ?? this.errorText,
  );
}
