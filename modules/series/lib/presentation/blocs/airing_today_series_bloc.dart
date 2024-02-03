import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_airing_today_series.dart';
import 'package:series/presentation/blocs/airing_today_series_event.dart';
import 'package:series/presentation/blocs/airing_today_series_state.dart';

class AiringTodaySeriesBloc
    extends Bloc<AiringTodaySeriesEvent, AiringTodaySeriesState> {
  final GetAiringTodaySeries _getAiringTodaySeries;

  AiringTodaySeriesBloc(this._getAiringTodaySeries)
      : super(AiringTodaySeriesEmpty()) {
    on<GetAiringTodaySeriesList>(
      (event, emit) async {
        emit(AiringTodaySeriesLoading());
        final result = await _getAiringTodaySeries.execute();

        result.fold(
          (failure) {
            emit(AiringTodaySeriesError(failure.message));
          },
          (data) {
            emit(AiringTodaySeriesHasData(data));
          },
        );
      },
    );
  }
}
