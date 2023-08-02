import 'package:data_repository/data_repository.dart';
import 'package:data_repository/src/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';

///
/// API Service implementation
///
class APIServiceImpl implements APIService {
  final Dio _dio = Dio();
  static final String clientAPIKey = '1d5a9a4a1358541ffe0e259e227b24da';
  static final String baseURL = 'https://api.openweathermap.org';

  // FIXME allow user to select city?
  static final List<int> _cityIds = [2643743, 2640729, 2655729, 2655603, 2653941, 2640358];

  CancelToken? _cancelToken;

  @override
  Future<Either<APIError, List<City>>> fetchWeather() async {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken?.cancel();
    }
    _cancelToken = CancelToken();

    try {
      var result = await _dio.get('$baseURL/data/2.5/group?id=${_cityIds.join(',')}&units=metric&appid=$clientAPIKey',
          cancelToken: _cancelToken);
      if (result.statusCode == 200) {
        var list = result.data['list'] as List;
        return Right(list.map((e) {
          dynamic weather = (e['weather'] as List).first;
          return City(
            id: e['id'],
            name: e['name'],
            temp: e['main']['temp'],
            feelsLikeTemp: e['main']['feels_like'],
            humidity: e['main']['humidity'],
            pressure: e['main']['feels_like'],
            sunrise: DateTime.fromMillisecondsSinceEpoch(e['sys']['sunrise'] * 1000),
            sunset: DateTime.fromMillisecondsSinceEpoch(e['sys']['sunset'] * 1000),
            tempMax: e['main']['temp_max'],
            tempMin: e['main']['temp_min'],
            wind: e['wind']['speed'],
            weather: Weather(weather['main'], weather['description'], _iconId(weather['icon'])),
          );
        }).toList());
      }
      return Left(APIError(result.statusCode!, 'Internal error'));
    } catch (ex) {
      return Left(
        APIError(500, ex.toString()),
      );
    }
  }
}

// 01d.png 	01n.png 	clear sky
// 02d.png 	02n.png 	few clouds
// 03d.png 	03n.png 	scattered clouds
// 04d.png 	04n.png 	broken clouds
// 09d.png 	09n.png 	shower rain
// 10d.png 	10n.png 	rain
// 11d.png 	11n.png 	thunderstorm
// 13d.png 	13n.png 	snow
// 50d.png 	50n.png 	mist
// FIXME add more animations!
String _iconId(String icon) {
  switch (icon) {
    case '01d':
    case '01n':
      return 'sunny.json';
    default:
      return 'cloudy.json';
  }
}
