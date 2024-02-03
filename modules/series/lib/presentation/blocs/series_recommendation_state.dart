import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';

abstract class SeriesRecommendationState extends Equatable {
  const SeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class SeriesRecommendationEmpty extends SeriesRecommendationState {}

class SeriesRecommendationLoading extends SeriesRecommendationState {}

class SeriesRecommendationError extends SeriesRecommendationState {
  final String message;

  const SeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesRecommendationHasData extends SeriesRecommendationState {
  final List<Series> series;

  const SeriesRecommendationHasData(this.series);

  @override
  List<Object> get props => [series];
}
