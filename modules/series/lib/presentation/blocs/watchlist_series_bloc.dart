import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/presentation/blocs/watchlist_series_event.dart';
import 'package:series/presentation/blocs/watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchListSeriesStatus _getWatchListSeriesStatus;
  final GetWatchlistSeries _getWatchlistSeries;
  final SaveWatchlistSeries _saveWatchlistSeries;
  final RemoveWatchlistSeries _removeWatchlistSeries;

  WatchlistSeriesBloc(
    this._getWatchListSeriesStatus,
    this._getWatchlistSeries,
    this._saveWatchlistSeries,
    this._removeWatchlistSeries,
  ) : super(WatchListSeriesEmpty()) {
    on<LoadWatchlistSeriesStatus>((event, emit) async {
      final result = await _getWatchListSeriesStatus.execute(event.id);
      String message = '';

      if (!result) {
        message = watchlistAddSuccessMessage;
      } else {
        message = watchlistRemoveSuccessMessage;
      }

      emit(WatchlistSeriesStatus(result, message));
    });

    on<AddWatchlistSeries>(
      (event, emit) async {
        emit(WatchListSeriesLoading());

        final result = await _saveWatchlistSeries.execute(event.series);

        result.fold(
          (failure) {
            emit(WatchlistSeriesError(failure.message));
          },
          (data) {
            add(LoadWatchlistSeriesStatus(event.series.id));
          },
        );
      },
    );

    on<DeleteWatchlistSeries>(
      (event, emit) async {
        emit(WatchListSeriesLoading());

        final result = await _removeWatchlistSeries.execute(event.series);

        result.fold(
          (failure) {
            emit(WatchlistSeriesError(failure.message));
          },
          (data) {
            add(LoadWatchlistSeriesStatus(event.series.id));
          },
        );
      },
    );

    on<FetchWatchlistSeries>(
      (event, emit) async {
        emit(WatchListSeriesLoading());

        final result = await _getWatchlistSeries.execute();

        result.fold(
          (failure) {
            emit(WatchlistSeriesError(failure.message));
          },
          (data) {
            emit(WatchlistSeriesHasData(data));
          },
        );
      },
    );
  }
}
