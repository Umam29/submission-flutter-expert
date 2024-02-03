import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/top_rated_series_bloc.dart';
import 'package:series/presentation/blocs/top_rated_series_event.dart';
import 'package:series/presentation/blocs/top_rated_series_state.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  const TopRatedSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedSeriesPage> createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TopRatedSeriesBloc>(context)
        .add(GetTopRatedSeriesList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state is TopRatedSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.result[index];
                  return SeriesCard(
                    series: serie,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
