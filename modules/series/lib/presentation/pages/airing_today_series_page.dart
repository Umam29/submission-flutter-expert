import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/airing_today_series_bloc.dart';
import 'package:series/presentation/blocs/airing_today_series_event.dart';
import 'package:series/presentation/blocs/airing_today_series_state.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class AiringTodaySeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-series';

  const AiringTodaySeriesPage({super.key});

  @override
  State<AiringTodaySeriesPage> createState() => _AiringTodaySeriesPageState();
}

class _AiringTodaySeriesPageState extends State<AiringTodaySeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<AiringTodaySeriesBloc>(context)
        .add(GetAiringTodaySeriesList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodaySeriesBloc, AiringTodaySeriesState>(
          builder: (context, state) {
            if (state is AiringTodaySeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodaySeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.result[index];
                  return SeriesCard(
                    series: serie,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is AiringTodaySeriesError) {
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
