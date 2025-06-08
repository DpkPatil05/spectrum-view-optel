class RedeemPointsScreenState {
  RedeemPointsScreenState({
    this.isLoading = false,
    this.success,
    this.errorText = '',
  });

  final bool isLoading;
  final bool? success;
  final String errorText;

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
