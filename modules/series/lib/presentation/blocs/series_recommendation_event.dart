import 'package:equatable/equatable.dart';

abstract class SeriesRecommendationEvent extends Equatable {
  const SeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetSeriesRecommendationResult extends SeriesRecommendationEvent {
  final int id;

  GetSeriesRecommendationResult(this.id);

  @override
  List<Object> get props => [id];
}
