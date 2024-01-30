import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetAiringTodaySeries {
  final SeriesRepository repository;

  GetAiringTodaySeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getAiringTodaySeries();
  }
}
