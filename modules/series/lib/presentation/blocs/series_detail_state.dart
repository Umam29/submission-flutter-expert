import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series_detail.dart';

abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  @override
  List<Object> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {}

class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailError extends SeriesDetailState {
  final String message;

  const SeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesDetail series;

  const SeriesDetailHasData(this.series);

  @override
  List<Object> get props => [series];
}
