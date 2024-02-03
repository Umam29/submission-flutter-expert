import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/blocs/movies_recommendation_event.dart';
import 'package:movies/presentation/blocs/movies_recommendation_state.dart';

class MoviesRecommendationBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MoviesRecommendationBloc(this._getMovieRecommendations)
      : super(MoviesRecommendationEmpty()) {
    on<GetMoviesRecommendationResult>(
      (event, emit) async {
        emit(MoviesRecommendationLoading());

        final result = await _getMovieRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(MoviesRecommendationError(failure.message));
          },
          (data) {
            emit(MoviesRecommendationHasData(data));
          },
        );
      },
    );
  }
}
