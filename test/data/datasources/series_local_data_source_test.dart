import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseSeriesHelper mockDatabaseSeriesHelper;

  setUp(() {
    mockDatabaseSeriesHelper = MockDatabaseSeriesHelper();
    dataSource =
        SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseSeriesHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchListSeries(testSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.insertWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchListSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchListSeries(testSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseSeriesHelper.removeWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchListSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series Detail By Id', () {
    final tId = 1;

    test('should return Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getBySeriesId(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getBySeriesId(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(mockDatabaseSeriesHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}
