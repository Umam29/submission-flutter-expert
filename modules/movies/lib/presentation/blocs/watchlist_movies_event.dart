import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie_detail.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistMovie extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const AddWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovie extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMoviesStatus extends WatchlistMoviesEvent {
  final int id;

  const LoadWatchlistMoviesStatus(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistMovies extends WatchlistMoviesEvent {}
