import 'package:equatable/equatable.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailResult extends MoviesDetailEvent {
  final int id;

  GetMovieDetailResult(this.id);

  @override
  List<Object> get props => [id];
}
