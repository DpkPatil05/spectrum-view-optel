enum TabOption { home }

class HomeScreenState {
  HomeScreenState({required this.isUserSignedIn, required this.activeTab});

  final bool isUserSignedIn;
  final TabOption activeTab;

  static HomeScreenState get defaultState =>
      HomeScreenState(isUserSignedIn: true, activeTab: TabOption.home);

  HomeScreenState copyWith({bool? isUserSignedIn, TabOption? activeTab}) =>
      HomeScreenState(
        isUserSignedIn: isUserSignedIn ?? this.isUserSignedIn,
        activeTab: activeTab ?? this.activeTab,
      );
}
