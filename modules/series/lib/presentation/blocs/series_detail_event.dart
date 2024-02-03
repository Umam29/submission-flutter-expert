import 'package:equatable/equatable.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class GetSeriesDetailResult extends SeriesDetailEvent {
  final int id;

  GetSeriesDetailResult(this.id);

  @override
  List<Object> get props => [id];
}
