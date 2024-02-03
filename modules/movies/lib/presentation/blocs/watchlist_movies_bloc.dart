import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/blocs/watchlist_movies_event.dart';
import 'package:movies/presentation/blocs/watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchListStatus _getWatchListStatus;
  final GetWatchlistMovies _getWatchlistMovies;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMoviesBloc(
    this._getWatchListStatus,
    this._getWatchlistMovies,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(WatchListMoviesEmpty()) {
    on<LoadWatchlistMoviesStatus>((event, emit) async {
      final result = await _getWatchListStatus.execute(event.id);
      String message = '';

      if (!result) {
        message = watchlistAddSuccessMessage;
      } else {
        message = watchlistRemoveSuccessMessage;
      }

      emit(WatchlistMovieStatus(result, message));
    });

    on<AddWatchlistMovie>(
      (event, emit) async {
        emit(WatchListMoviesLoading());

        final result = await _saveWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            add(LoadWatchlistMoviesStatus(event.movie.id));
          },
        );
      },
    );

    on<RemoveWatchlistMovie>(
      (event, emit) async {
        emit(WatchListMoviesLoading());

        final result = await _removeWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            add(LoadWatchlistMoviesStatus(event.movie.id));
          },
        );
      },
    );

    on<FetchWatchlistMovies>(
      (event, emit) async {
        emit(WatchListMoviesLoading());

        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            emit(WatchlistMovieHasData(data));
          },
        );
      },
    );
  }
}
