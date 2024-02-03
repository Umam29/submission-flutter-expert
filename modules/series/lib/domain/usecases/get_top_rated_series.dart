import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository seriesRepository;

  GetTopRatedSeries(this.seriesRepository);

  Future<Either<Failure, List<Series>>> execute() {
    return seriesRepository.getTopRatedSeries();
  }
}
