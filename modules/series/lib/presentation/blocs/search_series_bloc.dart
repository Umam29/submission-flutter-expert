import 'package:core/common/event_transformer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/blocs/search_series_event.dart';
import 'package:series/presentation/blocs/search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries _searchSeries;

  SearchSeriesBloc(this._searchSeries) : super(SearchSeriesEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchSeriesLoading());
        final result = await _searchSeries.execute(query);

        result.fold(
          (failure) {
            emit(SearchSeriesError(failure.message));
          },
          (data) {
            emit(SearchSeriesHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
