import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entitites/movie.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
