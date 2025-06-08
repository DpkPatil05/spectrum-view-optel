class MarkAsBoughtScreenState {
  MarkAsBoughtScreenState({this.isLoading = false, this.success});

  final bool isLoading;
  final bool? success;

  static MarkAsBoughtScreenState get defaultState =>
      MarkAsBoughtScreenState(isLoading: false, success: null);

  MarkAsBoughtScreenState copyWith({bool? isLoading, bool? success}) =>
      MarkAsBoughtScreenState(
        isLoading: isLoading ?? this.isLoading,
        success: success ?? this.success,
      );
}
