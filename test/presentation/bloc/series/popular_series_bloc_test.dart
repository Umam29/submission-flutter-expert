import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularSeriesBloc _popularSeriesBloc;
  late MockGetPopularSeries _mockGetPopularSeries;

  setUp(() {
    _mockGetPopularSeries = MockGetPopularSeries();
    _popularSeriesBloc = PopularSeriesBloc(_mockGetPopularSeries);
  });

  test('initial state should be empty', () {
    expect(_popularSeriesBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return _popularSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularSeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockGetPopularSeries.execute());
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(_mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return _popularSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularSeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(_mockGetPopularSeries.execute());
    },
  );
}
