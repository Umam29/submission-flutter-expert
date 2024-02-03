import 'package:equatable/equatable.dart';

abstract class MoviesRecommendationEvent extends Equatable {
  const MoviesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesRecommendationResult extends MoviesRecommendationEvent {
  final int id;

  const GetMoviesRecommendationResult(this.id);

  @override
  List<Object> get props => [id];
}
