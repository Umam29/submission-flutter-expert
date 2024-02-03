import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/presentation/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/blocs/airing_today_series_bloc.dart';
import 'package:series/presentation/blocs/airing_today_series_event.dart';
import 'package:series/presentation/blocs/airing_today_series_state.dart';
import 'package:series/presentation/blocs/popular_series_bloc.dart';
import 'package:series/presentation/blocs/popular_series_event.dart';
import 'package:series/presentation/blocs/popular_series_state.dart';
import 'package:series/presentation/blocs/top_rated_series_bloc.dart';
import 'package:series/presentation/blocs/top_rated_series_event.dart';
import 'package:series/presentation/blocs/top_rated_series_state.dart';
import 'package:series/presentation/pages/airing_today_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:movies/movies.dart';

class HomeSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home_series';

  const HomeSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeSeriesPage> createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      BlocProvider.of<AiringTodaySeriesBloc>(context)
          .add(GetAiringTodaySeriesList());
      BlocProvider.of<PopularSeriesBloc>(context).add(GetPopularSeriesList());
      BlocProvider.of<TopRatedSeriesBloc>(context).add(GetTopRatedSeriesList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        onTapMovie: () =>
            Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME),
        onTapSeries: () => Navigator.pop(context),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchSeriesPage.ROUTE_NAME,
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () {
                  Navigator.pushNamed(
                      context, AiringTodaySeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<AiringTodaySeriesBloc, AiringTodaySeriesState>(
                builder: (context, state) {
                  if (state is AiringTodaySeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AiringTodaySeriesHasData) {
                    return SeriesList(serieses: state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                builder: (context, state) {
                  if (state is PopularSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSeriesHasData) {
                    return SeriesList(serieses: state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesHasData) {
                    return SeriesList(serieses: state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('See More'),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      )
    ],
  );
}

class SeriesList extends StatelessWidget {
  final List<Series> serieses;

  const SeriesList({super.key, required this.serieses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: serieses.length,
        itemBuilder: (context, index) {
          final series = serieses[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
