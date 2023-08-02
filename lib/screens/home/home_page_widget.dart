import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_demo_app/screens/home/widgets/widgets.dart';
import 'bloc/home_page_bloc.dart';

///
/// Implementation of the Home Page widget
///
class HomePageWidget extends StatelessWidget {
  static Widget instance() => BlocProvider(
        create: (context) {
          return HomePageBloc(
            dataRepository: RepositoryProvider.of<AppDataRepository>(context),
          );
        },
        child: HomePageWidget(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageBlocState>(
      listenWhen: (previous, current) => current is HomePageBlocStateCitySelected || current is HomePageBlocStateError,
      listener: (context, state) {
        if (state is HomePageBlocStateCitySelected) {
          context.push('/city', extra: state.city);
        } else if (state is HomePageBlocStateError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong, please try again"),
          ));
        }
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: CityListWidget(),
      ),
    );
  }
}
