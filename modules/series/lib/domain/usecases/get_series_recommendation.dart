import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesRecommendation {
  final SeriesRepository repository;

  GetSeriesRecommendation(this.repository);

  Future<Either<Failure, List<Series>>> execute(int id) {
    return repository.getRecommendation(id);
  }
}
