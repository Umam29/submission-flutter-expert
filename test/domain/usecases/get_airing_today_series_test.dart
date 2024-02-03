import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_airing_today_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodaySeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetAiringTodaySeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockSeriesRepository.getAiringTodaySeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
