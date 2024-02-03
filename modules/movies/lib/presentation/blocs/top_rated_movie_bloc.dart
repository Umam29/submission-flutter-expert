import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/blocs/top_rated_movie_event.dart';
import 'package:movies/presentation/blocs/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<GetTopRatedMovieList>((event, emit) async {
      emit(TopRatedMovieLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (data) {
          emit(TopRatedMovieHasData(data));
        },
      );
    });
  }
}
