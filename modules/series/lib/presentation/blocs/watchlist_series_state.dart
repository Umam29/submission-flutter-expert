import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

abstract class WatchlistSeriesState extends Equatable {
  const WatchlistSeriesState();

  @override
  List<Object> get props => [];
}

class WatchListSeriesEmpty extends WatchlistSeriesState {}

class WatchListSeriesLoading extends WatchlistSeriesState {}

class WatchlistSeriesError extends WatchlistSeriesState {
  final String message;

  const WatchlistSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSeriesHasData extends WatchlistSeriesState {
  final List<Series> series;

  const WatchlistSeriesHasData(this.series);

  @override
  List<Object> get props => [series];
}

class WatchlistSeriesStatus extends WatchlistSeriesState {
  final bool result;
  final String message;

  const WatchlistSeriesStatus(this.result, this.message);

  @override
  List<Object> get props => [result, message];
}
