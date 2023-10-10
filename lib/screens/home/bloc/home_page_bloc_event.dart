part of 'home_page_bloc.dart';

abstract class HomePageBlocEvent {
  const HomePageBlocEvent();
}

/// When new data should be retrieved
class HomePageBlocEventOnFetchData extends HomePageBlocEvent {}

/// When user selects a city
class HomePageBlocEventOnCitySelected extends HomePageBlocEvent {
  final City city;
  HomePageBlocEventOnCitySelected(this.city);
}
