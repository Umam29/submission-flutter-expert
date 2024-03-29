import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

abstract class TopRatedSeriesState extends Equatable {
  const TopRatedSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedSeriesEmpty extends TopRatedSeriesState {}

class TopRatedSeriesLoading extends TopRatedSeriesState {}

class TopRatedSeriesError extends TopRatedSeriesState {
  final String message;

  const TopRatedSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedSeriesHasData extends TopRatedSeriesState {
  final List<Series> result;

  const TopRatedSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
