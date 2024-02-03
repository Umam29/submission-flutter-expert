import 'package:equatable/equatable.dart';
import 'package:movies/domain/entitites/movie_detail.dart';

abstract class MoviesDetailState extends Equatable {
  const MoviesDetailState();

  @override
  List<Object> get props => [];
}

class MoviesDetailEmpty extends MoviesDetailState {}

class MoviesDetailLoading extends MoviesDetailState {}

class MoviesDetailError extends MoviesDetailState {
  final String message;

  const MoviesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesDetailHasData extends MoviesDetailState {
  final MovieDetail movie;

  const MoviesDetailHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
