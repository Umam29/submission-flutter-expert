import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  GetWatchlistMovies,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      mockGetWatchListStatus,
      mockGetWatchlistMovies,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WatchListMoviesEmpty());
  });

  const tId = 1;

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Wathclist status should emit Status when data is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistMoviesStatus(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieStatus(true, watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Event FetchWathclist should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchListMoviesLoading(),
      WatchlistMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Event AddWathclist should emit [Loading, Status] when data added successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      WatchListMoviesLoading(),
      WatchlistMovieStatus(false, watchlistAddSuccessMessage)
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Event AddWathclist should emit Error when data added unsuccessfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      WatchListMoviesLoading(),
      const WatchlistMoviesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Event RemoveWathclist should emit [Loading, Status] when data removed successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    expect: () => [
      WatchListMoviesLoading(),
      WatchlistMovieStatus(true, watchlistRemoveSuccessMessage)
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Event RemoveWathclist should emit Error when data removed unsuccessfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    expect: () => [
      WatchListMoviesLoading(),
      const WatchlistMoviesError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
