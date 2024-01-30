import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/airing_today_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<AiringTodaySeriesNotifier>(context, listen: false)
            .fetchAiringTodaySeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodaySeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = data.series[index];
                  return SeriesCard(
                    series: serie,
                  );
                },
                itemCount: data.series.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
