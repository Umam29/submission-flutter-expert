import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

abstract class AiringTodaySeriesState extends Equatable {
  const AiringTodaySeriesState();

  @override
  List<Object> get props => [];
}

class AiringTodaySeriesEmpty extends AiringTodaySeriesState {}

class AiringTodaySeriesLoading extends AiringTodaySeriesState {}

class AiringTodaySeriesError extends AiringTodaySeriesState {
  final String message;

  const AiringTodaySeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTodaySeriesHasData extends AiringTodaySeriesState {
  final List<Series> result;

  const AiringTodaySeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
