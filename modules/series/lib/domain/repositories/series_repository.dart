import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getAiringTodaySeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getRecommendation(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail series);
  Future<Either<Failure, String>> removeWatchlistSeries(SeriesDetail series);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Series>>> getWatchlistSeries();
}
