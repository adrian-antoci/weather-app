import 'package:bloc/bloc.dart';

import 'package:data_repository/data_repository.dart';
import 'package:either_dart/either.dart';
part 'home_page_bloc_event.dart';
part 'home_page_bloc_state.dart';

///
/// The Bloc implementation of the Home screen.
///
class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageBlocState> {
  HomePageBloc({
    required AppDataRepository dataRepository,
  }) : super(HomePageBlocStateLoading()) {
    on<HomePageBlocEventOnCitySelected>((event, emit) => emit(HomePageBlocStateCitySelected(event.city)));
    on<HomePageBlocEventOnFetchData>((event, emit) => _onFetchResults(dataRepository: dataRepository, emit: emit));
  }

  List<City> cities = [];

  void _onFetchResults({required AppDataRepository dataRepository, required Emitter<HomePageBlocState> emit}) async {
    var weather = await dataRepository.fetchWeather();
    if (weather is Left) {
      // ignore error type
      emit(HomePageBlocStateError());
    } else {
      cities = weather.right;
      emit(HomePageBlocStateResultsAvailable());
    }
  }
}
