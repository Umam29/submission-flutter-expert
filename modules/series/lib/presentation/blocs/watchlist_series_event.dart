import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series_detail.dart';

abstract class WatchlistSeriesEvent extends Equatable {
  const WatchlistSeriesEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistSeries extends WatchlistSeriesEvent {
  final SeriesDetail series;

  const AddWatchlistSeries(this.series);

  @override
  List<Object> get props => [series];
}

class DeleteWatchlistSeries extends WatchlistSeriesEvent {
  final SeriesDetail series;

  const DeleteWatchlistSeries(this.series);

  @override
  List<Object> get props => [series];
}

class LoadWatchlistSeriesStatus extends WatchlistSeriesEvent {
  final int id;

  const LoadWatchlistSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistSeries extends WatchlistSeriesEvent {}
