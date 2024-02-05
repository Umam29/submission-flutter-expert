import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistSeries,
  GetWatchListSeriesStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries
])
void main() {
  late WatchlistSeriesBloc watchlistSeriesBloc;
  late MockGetWatchListSeriesStatus mockGetWatchListSeriesStatus;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListSeriesStatus = MockGetWatchListSeriesStatus();
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlist = MockRemoveWatchlistSeries();
    watchlistSeriesBloc = WatchlistSeriesBloc(
      mockGetWatchListSeriesStatus,
      mockGetWatchlistSeries,
      mockSaveWatchlistSeries,
      mockRemoveWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistSeriesBloc.state, WatchListSeriesEmpty());
  });

  const tId = 1;

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Wathclist status should emit Status when data is gotten successfully',
    build: () {
      when(mockGetWatchListSeriesStatus.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistSeriesStatus(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const WatchlistSeriesStatus(true, watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockGetWatchListSeriesStatus.execute(tId));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event FetchWathclist should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchListSeriesLoading(),
      WatchlistSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event AddWathclist should emit [Loading, Status] when data added successfully',
    build: () {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      const WatchlistSeriesStatus(false, watchlistAddSuccessMessage)
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event AddWathclist should emit Error when data added unsuccessfully',
    build: () {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      const WatchlistSeriesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event RemoveWathclist should emit [Loading, Status] when data removed successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      const WatchlistSeriesStatus(true, watchlistRemoveSuccessMessage)
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testSeriesDetail));
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Event RemoveWathclist should emit Error when data removed unsuccessfully',
    build: () {
      when(mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistSeries(testSeriesDetail)),
    expect: () => [
      WatchListSeriesLoading(),
      const WatchlistSeriesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testSeriesDetail));
    },
  );
}
