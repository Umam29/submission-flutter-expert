import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/series_response.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getAiringTodaySeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<SeriesDetailModel> getSeriesDetail(int id);
  Future<List<SeriesModel>> getRecommendation(int id);
  Future<List<SeriesModel>> searchSeries(String query);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getAiringTodaySeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailModel> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/${id}?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}
