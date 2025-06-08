class MarkAsBoughtScreenState {
  MarkAsBoughtScreenState({
    this.success,
    this.isVerified,
    this.isBought,
    this.isLoading = false,
    this.errorText = '',
  });

  final bool isLoading;
  final String errorText;
  final bool? success;
  final bool? isVerified;
  final bool? isBought;

  static MarkAsBoughtScreenState get defaultState => MarkAsBoughtScreenState(
    isLoading: false,
    success: null,
    isVerified: null,
    isBought: null,
    errorText: '',
  );

  MarkAsBoughtScreenState copyWith({
    bool? isLoading,
    bool? success,
    bool? isBought,
    bool? isVerified,
    String? errorText,
  }) => MarkAsBoughtScreenState(
    isLoading: isLoading ?? this.isLoading,
    success: success ?? this.success,
    isBought: isBought ?? this.isBought,
    isVerified: isVerified ?? this.isVerified,
    errorText: errorText ?? this.errorText,
  );
}
