import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository repository;

  GetWatchlistSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getWatchlistSeries();
  }
}
