import 'package:data_repository/data_repository.dart';
import 'package:either_dart/either.dart';

abstract class APIService {
  ///
  /// Will fetch and return a list of [City] or an [APIError]
  ///
  Future<Either<APIError, List<City>>> fetchWeather();
}
