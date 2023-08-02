import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_demo_app/style/style.dart';

import 'bloc/city_page_bloc.dart';

///
/// Implementation of the City Page as a widget.
///
class CityPageWidget extends StatelessWidget {
  const CityPageWidget({super.key});

  static Widget instance(City city) => BlocProvider(
        create: (context) {
          return CityPageBloc(
            dataRepository: RepositoryProvider.of<AppDataRepository>(context),
            city: city,
          );
        },
        child: const CityPageWidget(),
      );

  @override
  Widget build(BuildContext context) {
    var city = context.read<CityPageBloc>().city;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(tag: '${city.name}_${city.temp}', child: Text('${city.temp}°', style: const TextStyle(fontSize: 56))),
                    Text(city.weather.description.capitalize()),
                  ],
                ),
                Hero(
                    tag: '${city.name}_${city.weather.icon}',
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Lottie.asset('assets/animations/${city.weather.icon}', width: 130))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                    tag: '${city.name}_pin',
                    child: Lottie.asset('assets/animations/pin.json', height: 80, repeat: false, animate: true)),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(tag: city.name, child: Text(city.name, style: const TextStyle(fontSize: 26))),
                    Text('Feels like ${city.feelsLikeTemp}°'),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              children: [
                _statWidget('thermometer.json', 'Range', 'Min ${city.tempMin}°\nMax ${city.tempMax}°'),
                _statWidget('wind.json', 'Wind', '${city.wind} km/h'),
                _statWidget('humidity.json', 'Humidity', '${city.humidity}%'),
                _statWidget('pressure.json', 'Pressure', '${city.pressure}hPa'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _statWidget(String icon, String title, String description) => Container(
        decoration: BoxDecoration(color: const Color(0xff202124), borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/$icon', height: 100),
            Text(title, style: const TextStyle(fontSize: 22)),
            const SizedBox(
              height: 8,
            ),
            Text(description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      );
}
