import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc _searchSeriesBloc;
  late MockSearchSeries _mockSearchSeries;

  setUp(() {
    _mockSearchSeries = MockSearchSeries();
    _searchSeriesBloc = SearchSeriesBloc(_mockSearchSeries);
  });

  test('initial state should be empty', () {
    expect(_searchSeriesBloc.state, SearchSeriesEmpty());
  });

  final tQuery = 'avatar';

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(_mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testSeriesList));
      return _searchSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(_mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(_mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return _searchSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(_mockSearchSeries.execute(tQuery));
    },
  );
}
