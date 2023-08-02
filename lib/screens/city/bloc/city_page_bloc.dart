import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
part 'city_page_bloc_event.dart';
part 'city_page_bloc_state.dart';

///
/// The Bloc implementation of the City page.
///
class CityPageBloc extends Bloc<CityPageBlocEvent, CityPageBlocState> {
  CityPageBloc({
    required AppDataRepository dataRepository,
    required this.city,
  }) : super(CityPageBlocStateDefault()) {}

  final City city;
}
