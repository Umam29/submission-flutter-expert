import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:series/series.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  //series
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseSeriesHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
