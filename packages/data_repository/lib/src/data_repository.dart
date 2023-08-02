import 'package:either_dart/either.dart';

import 'models/models.dart';

abstract class AppDataRepository {
  ///
  /// Will return a list of [City].
  ///
  /// TODO implement caching
  ///
  Future<Either<APIError, List<City>>> fetchWeather();
}
