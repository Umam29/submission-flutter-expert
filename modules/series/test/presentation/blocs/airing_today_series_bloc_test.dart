import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_series_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodaySeries])
void main() {
  late AiringTodaySeriesBloc airingTodaySeriesBloc;
  late MockGetAiringTodaySeries mockGetAiringTodaySeries;

  setUp(() {
    mockGetAiringTodaySeries = MockGetAiringTodaySeries();
    airingTodaySeriesBloc = AiringTodaySeriesBloc(mockGetAiringTodaySeries);
  });

  test('initial state should be empty', () {
    expect(airingTodaySeriesBloc.state, AiringTodaySeriesEmpty());
  });

  blocTest<AiringTodaySeriesBloc, AiringTodaySeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return airingTodaySeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodaySeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodaySeriesLoading(),
      AiringTodaySeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );

  blocTest<AiringTodaySeriesBloc, AiringTodaySeriesState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodaySeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodaySeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodaySeriesLoading(),
      const AiringTodaySeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodaySeries.execute());
    },
  );
}
