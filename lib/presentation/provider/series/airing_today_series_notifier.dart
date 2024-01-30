import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/usecases/series/get_airing_today_series.dart';
import 'package:flutter/cupertino.dart';

class AiringTodaySeriesNotifier extends ChangeNotifier {
  final GetAiringTodaySeries getAiringTodaySeries;

  AiringTodaySeriesNotifier(this.getAiringTodaySeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodaySeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodaySeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
