import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/entities/series/series_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_recommendation.dart';
import 'package:ditonton/domain/usecases/series/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/series/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/series/save_watchlist_series.dart';
import 'package:flutter/material.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendation getSeriesRecommendation;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getSeriesRecommendation,
    required this.getWatchListSeriesStatus,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  });

  late SeriesDetail _series;
  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  List<Series> _seriesRecommendation = [];
  List<Series> get seriesRecommendation => _seriesRecommendation;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistSeries = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlistSeries;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendation.execute(id);

    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _recommendationState = RequestState.Loading;
        _series = series;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (serieses) {
            _seriesRecommendation = serieses;
            _recommendationState = RequestState.Loaded;
            notifyListeners();
          },
        );
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistSeriesMessage = '';
  String get watchlistSeriesMessage => _watchlistSeriesMessage;

  Future<void> addWatchlistSeries(SeriesDetail series) async {
    final result = await saveWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistSeriesMessage = failure.message;
      },
      (successMessage) async {
        _watchlistSeriesMessage = successMessage;
      },
    );

    await loadWatchlistSeriesStatus(series.id);
  }

  Future<void> removeFromWatchlistSeries(SeriesDetail series) async {
    final result = await removeWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistSeriesMessage = failure.message;
      },
      (successMessage) async {
        _watchlistSeriesMessage = successMessage;
      },
    );

    await loadWatchlistSeriesStatus(series.id);
  }

  Future<void> loadWatchlistSeriesStatus(int id) async {
    final result = await getWatchListSeriesStatus.execute(id);
    _isAddedtoWatchlistSeries = result;
    notifyListeners();
  }
}
