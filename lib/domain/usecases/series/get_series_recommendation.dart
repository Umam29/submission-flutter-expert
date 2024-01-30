import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetSeriesRecommendation {
  final SeriesRepository repository;

  GetSeriesRecommendation(this.repository);

  Future<Either<Failure, List<Series>>> execute(int id) {
    return repository.getRecommendation(id);
  }
}
