import 'package:data_repository/src/data_repository.dart';
import 'package:data_repository/src/models/api_error.dart';
import 'package:data_repository/src/models/city.dart';
import 'package:either_dart/src/either.dart';

import 'api/api.dart';

class AppDataRepositoryImpl implements AppDataRepository {
  final APIService _apiService = APIServiceImpl();

  @override
  Future<Either<APIError, List<City>>> fetchWeather() => _apiService.fetchWeather();
}
