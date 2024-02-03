import 'package:equatable/equatable.dart';

abstract class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedSeriesList extends TopRatedSeriesEvent {}
