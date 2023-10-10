import 'package:data_repository/data_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_demo_app/screens/home/bloc/home_page_bloc.dart';

class MockDataRepository extends Mock implements AppDataRepository {}

void main() {
  var dataRepoMock = MockDataRepository();

  group('HomePageBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => HomePageBloc(dataRepository: dataRepoMock),
      expect: () => [],
    );

    blocTest(
      'emits [HomePageBlocStateCitySelected] when City is selected',
      build: () => HomePageBloc(dataRepository: dataRepoMock),
      act: (bloc) => bloc.add(HomePageBlocEventOnCitySelected(City.empty())),
      expect: () => [isA<HomePageBlocStateCitySelected>()],
    );

    when(() => dataRepoMock.fetchWeather()).thenAnswer((_) => Future(() => Left(APIError(504, "Error"))));
    blocTest('fetchWeather() is called when [HomePageBlocEventOnFetchResults] is emitted',
        build: () => HomePageBloc(dataRepository: dataRepoMock),
        act: (bloc) => bloc.add(HomePageBlocEventOnFetchData()),
        verify: (_) {
          verify(() => dataRepoMock.fetchWeather()).called(1);
        });

    when(() => dataRepoMock.fetchWeather()).thenAnswer((_) => Future(() => Right([City.empty()])));
    blocTest(
      'emits [HomePageBlocEventOnFetchResults] data repo response is returning results',
      build: () => HomePageBloc(dataRepository: dataRepoMock),
      act: (bloc) => bloc.add(HomePageBlocEventOnFetchData()),
      expect: () => [isA<HomePageBlocStateResultsAvailable>()],
    );

    when(() => dataRepoMock.fetchWeather()).thenAnswer((_) => Future(() => Right([City.empty()])));
    blocTest(
      'emits [HomePageBlocEventOnFetchResults] and checks if results are available',
      build: () => HomePageBloc(dataRepository: dataRepoMock),
      act: (bloc) => bloc.add(HomePageBlocEventOnFetchData()),
      verify: (bloc) {
        expect(1, bloc.cities.length);
      },
    );
  });
}
