import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'airing_today_series_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodaySeries])
void main() {
  late AiringTodaySeriesBloc _airingTodaySeriesBloc;
  late MockGetAiringTodaySeries _mockGetAiringTodaySeries;

  setUp(() {
    _mockGetAiringTodaySeries = MockGetAiringTodaySeries();
    _airingTodaySeriesBloc = AiringTodaySeriesBloc(_mockGetAiringTodaySeries);
  });

  test('initial state should be empty', () {
    expect(_airingTodaySeriesBloc.state, AiringTodaySeriesEmpty());
  });

  blocTest<AiringTodaySeriesBloc, AiringTodaySeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return _airingTodaySeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodaySeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodaySeriesLoading(),
      AiringTodaySeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockGetAiringTodaySeries.execute());
    },
  );

  blocTest<AiringTodaySeriesBloc, AiringTodaySeriesState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(_mockGetAiringTodaySeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return _airingTodaySeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodaySeriesList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodaySeriesLoading(),
      AiringTodaySeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(_mockGetAiringTodaySeries.execute());
    },
  );
}
