import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_demo_app/screens/home/bloc/home_page_bloc.dart';

/// Widget that displays a [City] as a card in a list.
class CityWidget extends StatelessWidget {
  const CityWidget(this.city, {super.key});

  final City city;
  static final _formatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomePageBloc>().add(HomePageBlocEventOnCitySelected(city)),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff202124),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                      tag: '${city.name}_pin',
                      child: Lottie.asset('assets/animations/pin.json',
                          height: 50, alignment: Alignment.topRight, repeat: false, animate: false)),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: city.name,
                          child: Text(
                            city.name,
                            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Sunrise ${_formatter.format(city.sunrise)} / Sunset ${_formatter.format(city.sunset)} '),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Hero(
                    tag: '${city.name}_${city.weather.icon}',
                    child: Lottie.asset('assets/animations/${city.weather.icon}', width: 70)),
                const SizedBox(
                  width: 5,
                ),
                Hero(
                    tag: '${city.name}_${city.temp}',
                    child: Text(
                      '${city.temp}°',
                      style: const TextStyle(fontSize: 21),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
