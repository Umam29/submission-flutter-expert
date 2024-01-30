import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series/db/database_series_helper.dart';
import 'package:ditonton/data/models/series/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchListSeries(SeriesTable series);
  Future<String> removeWatchListSeries(SeriesTable series);
  Future<SeriesTable?> getBySeriesId(int id);
  Future<List<SeriesTable>> getWatchlistSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseSeriesHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchListSeries(SeriesTable series) async {
    try {
      await databaseHelper.insertWatchlistSeries(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchListSeries(SeriesTable series) async {
    try {
      await databaseHelper.removeWatchlistSeries(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getBySeriesId(int id) async {
    final result = await databaseHelper.getSeriesById(id);

    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistSeries();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
}
