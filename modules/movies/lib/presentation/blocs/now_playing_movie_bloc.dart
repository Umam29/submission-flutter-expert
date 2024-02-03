import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/blocs/now_playing_movie_event.dart';
import 'package:movies/presentation/blocs/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<GetNowPlayingMovieList>(
      (event, emit) async {
        emit(NowPlayingMovieLoading());
        final result = await _getNowPlayingMovies.execute();

        result.fold(
          (failure) {
            emit(NowPlayingMovieError(failure.message));
          },
          (data) {
            emit(NowPlayingMovieHasData(data));
          },
        );
      },
    );
  }
}
