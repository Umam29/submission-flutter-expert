import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendation])
void main() {
  late SeriesRecommendationBloc _seriesRecommendationBloc;
  late MockGetSeriesRecommendation _mockGetSeriesRecommendation;

  setUp(() {
    _mockGetSeriesRecommendation = MockGetSeriesRecommendation();
    _seriesRecommendationBloc =
        SeriesRecommendationBloc(_mockGetSeriesRecommendation);
  });

  test('initial state should be empty', () {
    expect(_seriesRecommendationBloc.state, SeriesRecommendationEmpty());
  });

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockGetSeriesRecommendation.execute(1))
          .thenAnswer((_) async => Right(testSeriesList));
      return _seriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetSeriesRecommendationResult(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SeriesRecommendationLoading(),
      SeriesRecommendationHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockGetSeriesRecommendation.execute(1));
    },
  );

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(_mockGetSeriesRecommendation.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return _seriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(GetSeriesRecommendationResult(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SeriesRecommendationLoading(),
      SeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(_mockGetSeriesRecommendation.execute(1));
    },
  );
}
