import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetPopularSeries {
  final SeriesRepository seriesRepository;

  GetPopularSeries(this.seriesRepository);

  Future<Either<Failure, List<Series>>> execute() {
    return seriesRepository.getPopularSeries();
  }
}
