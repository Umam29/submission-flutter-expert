import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistSeries,
  GetWatchListSeriesStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries
])
void main() {
  late WatchlistSeriesBloc _watchlistSeriesBloc;
  late MockGetWatchListSeriesStatus _mockGetWatchListSeriesStatus;
  late MockGetWatchlistSeries _mockGetWatchlistSeries;
  late MockSaveWatchlistSeries _mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries _mockRemoveWatchlist;

  setUp(() {
    _mockGetWatchListSeriesStatus = MockGetWatchListSeriesStatus();
    _mockGetWatchlistSeries = MockGetWatchlistSeries();
    _mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    _mockRemoveWatchlist = MockRemoveWatchlistSeries();
    _watchlistSeriesBloc = WatchlistSeriesBloc(
      _mockGetWatchListSeriesStatus,
      _mockGetWatchlistSeries,
      _mockSaveWatchlistSeries,
      _mockRemoveWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(_watchlistSeriesBloc.state, WatchListSeriesEmpty());
  });

  final tId = 1;

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Wathclist status should emit Status when data is gotten successfully',
    build: () {
      when(_mockGetWatchListSeriesStatus.execute(tId))
          .thenAnswer((_) async => true);
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistSeriesStatus(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistSeriesStatus(true, watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(_mockGetWatchListSeriesStatus.execute(tId));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event FetchWathclist should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event AddWathclist should emit [Loading, Status] when data added successfully',
    build: () {
      when(_mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
      when(_mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesStatus(false, watchlistAddSuccessMessage)
    ],
    verify: (bloc) {
      verify(_mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event AddWathclist should emit Error when data added unsuccessfully',
    build: () {
      when(_mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(_mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event RemoveWathclist should emit [Loading, Status] when data removed successfully',
    build: () {
      when(_mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
      when(_mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesStatus(true, watchlistRemoveSuccessMessage)
    ],
    verify: (bloc) {
      verify(_mockRemoveWatchlist.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event RemoveWathclist should emit Error when data removed unsuccessfully',
    build: () {
      when(_mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return _watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(_mockRemoveWatchlist.execute(testSeriesDetail));
    },
  );
}
