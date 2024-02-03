import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/popular_series_bloc.dart';
import 'package:series/presentation/blocs/popular_series_event.dart';
import 'package:series/presentation/blocs/popular_series_state.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  const PopularSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularSeriesPage> createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<PopularSeriesBloc>(context)
        .add(GetPopularSeriesList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.result[index];
                  return SeriesCard(
                    series: serie,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularSeriesError) {
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
