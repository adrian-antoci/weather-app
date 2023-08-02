import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo_app/screens/home/bloc/home_page_bloc.dart';
import 'city_widget.dart';

///
/// The search results widget.
/// Will display a list of [City].
///
class CityListWidget extends StatelessWidget {
  const CityListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageBlocState>(
      buildWhen: (previous, current) => current is HomePageBlocStateLoading || current is HomePageBlocStateResultsAvailable,
      builder: (context, state) {
        if (state is HomePageBlocStateLoading) {
          return _loadingWidget();
        } else if (state is HomePageBlocStateResultsAvailable) {
          return _listViewWidget(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  /// The progress indicator widget displayed while results are loading
  Widget _loadingWidget() => const Center(
        child: CircularProgressIndicator(),
      );

  /// The list of cities
  Widget _listViewWidget(BuildContext context) => CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 5,
            expandedHeight: 170.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              title: Text(
                'Open Weather',
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CityWidget(context.read<HomePageBloc>().cities[index]),
              childCount: context.read<HomePageBloc>().cities.length,
            ),
          ),
        ],
      );
}
