import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MoviesDetailBloc moviesDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    moviesDetailBloc = MoviesDetailBloc(mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(moviesDetailBloc.state, MoviesDetailEmpty());
  });

  const tId = 1;

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return moviesDetailBloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailResult(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, Error] when get movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return moviesDetailBloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailResult(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MoviesDetailLoading(),
      const MoviesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
