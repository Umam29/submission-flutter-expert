import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_series_recommendation.dart';
import 'package:series/presentation/blocs/series_recommendation_event.dart';
import 'package:series/presentation/blocs/series_recommendation_state.dart';

class SeriesRecommendationBloc
    extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetSeriesRecommendation _getSeriesRecommendation;

  SeriesRecommendationBloc(this._getSeriesRecommendation)
      : super(SeriesRecommendationEmpty()) {
    on<GetSeriesRecommendationResult>(
      (event, emit) async {
        emit(SeriesRecommendationLoading());

        final result = await _getSeriesRecommendation.execute(event.id);

        result.fold(
          (failure) {
            emit(SeriesRecommendationError(failure.message));
          },
          (data) {
            emit(SeriesRecommendationHasData(data));
          },
        );
      },
    );
  }
}
