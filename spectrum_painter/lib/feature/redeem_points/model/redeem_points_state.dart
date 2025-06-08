class RedeemPointsScreenState {
  RedeemPointsScreenState({
    this.isLoading = false,
    this.errorText = '',
    this.success,
  });

  final bool isLoading;
  final String errorText;
  final bool? success;

  static RedeemPointsScreenState get defaultState =>
      RedeemPointsScreenState(isLoading: false, success: null, errorText: '');

  RedeemPointsScreenState copyWith({
    bool? isLoading,
    bool? success,
    String? errorText,
  }) => RedeemPointsScreenState(
    isLoading: isLoading ?? this.isLoading,
    success: success ?? this.success,
    errorText: errorText ?? this.errorText,
  );
}
