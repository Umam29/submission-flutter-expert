import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchListMoviesEmpty extends WatchlistMoviesState {}

class WatchListMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMoviesState {
  final List<Movie> movies;

  const WatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class WatchlistMovieStatus extends WatchlistMoviesState {
  final bool result;
  final String message;

  WatchlistMovieStatus(this.result, this.message);

  @override
  List<Object> get props => [result, message];
}
