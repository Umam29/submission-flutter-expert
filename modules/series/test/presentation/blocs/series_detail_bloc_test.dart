import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late SeriesDetailBloc seriesDetailBloc;
  late MockGetSeriesDetail mockGetSeriesDetail;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    seriesDetailBloc = SeriesDetailBloc(mockGetSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(seriesDetailBloc.state, SeriesDetailEmpty());
  });

  const tId = 1;

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return seriesDetailBloc;
    },
    act: (bloc) => bloc.add(GetSeriesDetailResult(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'Should emit [Loading, Error] when get series is unsuccessful',
    build: () {
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return seriesDetailBloc;
    },
    act: (bloc) => bloc.add(GetSeriesDetailResult(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SeriesDetailLoading(),
      const SeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );
}
