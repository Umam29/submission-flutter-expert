import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: '/eWF3oRyL4QWaidN9F4uvM7cBJUV.jpg',
    genreIds: [10766],
    id: 206559,
    originCountry: ['ZA'],
    originalLanguage: 'af',
    originalName: 'Binnelanders',
    overview: '',
    popularity: 3533.82,
    posterPath: '/v9nGSRx5lFz6KEgfmgHJMSgaARC.jpg',
    firstAirDate: '2005-10-13',
    name: 'Binnelanders',
    voteAverage: 6.288,
    voteCount: 33,
  );

  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/eWF3oRyL4QWaidN9F4uvM7cBJUV.jpg",
            "genre_ids": [10766],
            "id": 206559,
            "origin_country": ['ZA'],
            "original_language": "af",
            "original_name": "Binnelanders",
            "overview": "",
            "popularity": 3533.82,
            "poster_path": "/v9nGSRx5lFz6KEgfmgHJMSgaARC.jpg",
            "first_air_date": "2005-10-13",
            "name": "Binnelanders",
            "vote_average": 6.288,
            "vote_count": 33,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
