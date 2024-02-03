import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/blocs/movies_detail_event.dart';
import 'package:movies/presentation/blocs/movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail _getMovieDetail;

  MoviesDetailBloc(
    this._getMovieDetail,
  ) : super(MoviesDetailEmpty()) {
    on<GetMovieDetailResult>((event, emit) async {
      emit(MoviesDetailLoading());

      final result = await _getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MoviesDetailError(failure.message));
        },
        (data) {
          emit(MoviesDetailHasData(data));
        },
      );
    });
  }
}
