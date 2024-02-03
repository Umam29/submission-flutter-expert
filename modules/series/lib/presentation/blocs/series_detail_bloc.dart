import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/blocs/series_detail_event.dart';
import 'package:series/presentation/blocs/series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail _getSeriesDetail;

  SeriesDetailBloc(
    this._getSeriesDetail,
  ) : super(SeriesDetailEmpty()) {
    on<GetSeriesDetailResult>((event, emit) async {
      emit(SeriesDetailLoading());

      final result = await _getSeriesDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(SeriesDetailError(failure.message));
        },
        (data) {
          emit(SeriesDetailHasData(data));
        },
      );
    });
  }
}
