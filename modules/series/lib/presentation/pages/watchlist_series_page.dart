import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/watchlist_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_series_event.dart';
import 'package:series/presentation/blocs/watchlist_series_state.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class WatchlistSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-series';

  const WatchlistSeriesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistSeriesPage> createState() => _WatchlistSeriesPageState();
}

class _WatchlistSeriesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<WatchlistSeriesBloc>(context)
        .add(FetchWatchlistSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistSeriesBloc>(context).add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (context, state) {
            if (state is WatchListSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.series[index];
                  return SeriesCard(
                    series: series,
                  );
                },
                itemCount: state.series.length,
              );
            } else if (state is WatchlistSeriesError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
