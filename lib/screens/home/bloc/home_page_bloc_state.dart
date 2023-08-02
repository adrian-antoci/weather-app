part of 'home_page_bloc.dart';

class HomePageBlocState {}

/// /// Default UI state, will display a spinner (for now, later we can do better!)
class HomePageBlocStateLoading extends HomePageBlocState {}

/// Update UI with new content
class HomePageBlocStateResultsAvailable extends HomePageBlocState {}

/// When a city has been selected
class HomePageBlocStateCitySelected extends HomePageBlocState {
  final City city;
  HomePageBlocStateCitySelected(this.city);
}

/// Show an error on the UI
class HomePageBlocStateError extends HomePageBlocState {}
