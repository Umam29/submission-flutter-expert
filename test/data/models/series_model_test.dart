import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/domain/entities/series.dart';

void main() {
  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['us'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: '2024-01-01',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeries = Series(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['us'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: '2024-01-01',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
