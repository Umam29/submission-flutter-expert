import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/blocs/top_rated_series_bloc.dart';
import 'package:series/presentation/blocs/top_rated_series_event.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries) : super(TopRatedSeriesEmpty()) {
    on<GetTopRatedSeriesList>(
      (event, emit) async {
        emit(TopRatedSeriesLoading());
        final result = await _getTopRatedSeries.execute();

        result.fold(
          (failure) {
            emit(TopRatedSeriesError(failure.message));
          },
          (data) {
            emit(TopRatedSeriesHasData(data));
          },
        );
      },
    );
  }
}
