import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_demo_app/screens/city/city_widget.dart';
import 'package:weather_demo_app/screens/home/widgets/animated_background.dart';
import 'package:weather_demo_app/screens/screens.dart';
import 'package:weather_demo_app/shared/card.dart';
import 'package:weather_demo_app/style/style.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

///
/// Main App widget implementation.
///
class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Welcome to the Weather App',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          displayLarge: const TextStyle(color: Colors.white),
          displayMedium: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          titleMedium: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  final _router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// Shell routes are used when the app requires multiple main routes, like /login/* and /dashboard/*
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        parentNavigatorKey: _rootNavigatorKey,
        observers: <NavigatorObserver>[HeroController()],
        builder: (context, state, child) {
          return isMobile(context)
              ? ColorAnimatedBackground(
                  child,
                )
              : WhiteCard(
                  child: ColorAnimatedBackground(
                    child,
                  ),
                );
        },
        routes: [
          GoRoute(
            path: '/home',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return HomePageWidget.instance();
            },
          ),
          GoRoute(
            path: '/city',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              //FIXME improve error state
              return state.extra == null ? const Text('Something went wrong') : CityPageWidget.instance(state.extra as City);
            },
          ),
        ],
      ),
    ],
  );
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
