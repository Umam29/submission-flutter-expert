import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:series/series.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseSeriesHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
