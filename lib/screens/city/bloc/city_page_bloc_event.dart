part of 'city_page_bloc.dart';

abstract class CityPageBlocEvent {
  const CityPageBlocEvent();
}

/// Will nav back to prev screen
class CityPageBlocEventOnBack extends CityPageBlocEvent {}
