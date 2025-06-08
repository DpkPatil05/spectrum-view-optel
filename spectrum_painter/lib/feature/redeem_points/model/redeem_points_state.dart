class RedeemPointsScreenState {
  RedeemPointsScreenState({this.isLoading = false, this.success});

  final bool isLoading;
  final bool? success;

  static RedeemPointsScreenState get defaultState =>
      RedeemPointsScreenState(isLoading: false, success: null);

  RedeemPointsScreenState copyWith({bool? isLoading, bool? success}) =>
      RedeemPointsScreenState(
        isLoading: isLoading ?? this.isLoading,
        success: success ?? this.success,
      );
}
