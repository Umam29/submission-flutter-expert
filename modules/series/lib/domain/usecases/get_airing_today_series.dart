import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetAiringTodaySeries {
  final SeriesRepository repository;

  GetAiringTodaySeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getAiringTodaySeries();
  }
}
