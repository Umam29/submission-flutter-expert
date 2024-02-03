import 'package:equatable/equatable.dart';

abstract class AiringTodaySeriesEvent extends Equatable {
  const AiringTodaySeriesEvent();

  @override
  List<Object> get props => [];
}

class GetAiringTodaySeriesList extends AiringTodaySeriesEvent {}
