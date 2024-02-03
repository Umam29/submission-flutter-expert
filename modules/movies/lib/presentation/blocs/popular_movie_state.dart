import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieEmpty extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends PopularMovieState {
  final List<Movie> result;

  const PopularMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
