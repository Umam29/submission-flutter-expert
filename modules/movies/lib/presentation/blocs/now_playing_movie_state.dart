import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieEmpty extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> result;

  const NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
