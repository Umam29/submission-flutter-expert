import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository seriesRepository;

  GetTopRatedSeries(this.seriesRepository);

  Future<Either<Failure, List<Series>>> execute() {
    return seriesRepository.getTopRatedSeries();
  }
}
