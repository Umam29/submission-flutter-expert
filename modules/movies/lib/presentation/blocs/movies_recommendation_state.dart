import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie.dart';

abstract class MoviesRecommendationState extends Equatable {
  const MoviesRecommendationState();

  @override
  List<Object> get props => [];
}

class MoviesRecommendationEmpty extends MoviesRecommendationState {}

class MoviesRecommendationLoading extends MoviesRecommendationState {}

class MoviesRecommendationError extends MoviesRecommendationState {
  final String message;

  const MoviesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesRecommendationHasData extends MoviesRecommendationState {
  final List<Movie> movies;

  const MoviesRecommendationHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
