import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesBloc _topRatedSeriesBloc;
  late MockGetTopRatedSeries _mockGetTopRatedSeries;

  setUp(() {
    _mockGetTopRatedSeries = MockGetTopRatedSeries();
    _topRatedSeriesBloc = TopRatedSeriesBloc(_mockGetTopRatedSeries);
  });

  test('initial state should be empty', () {
    expect(_topRatedSeriesBloc.state, TopRatedSeriesEmpty());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return _topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedSeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(_mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return _topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedSeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(_mockGetTopRatedSeries.execute());
    },
  );
}
