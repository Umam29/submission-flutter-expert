import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';

class AiringTodaySeriesEventFake extends Fake
    implements AiringTodaySeriesEvent {}

class AiringTodaySeriesStateFake extends Fake
    implements AiringTodaySeriesState {}

class MockAiringTodaySeriesBloc
    extends MockBloc<AiringTodaySeriesEvent, AiringTodaySeriesState>
    implements AiringTodaySeriesBloc {}

void main() {
  late MockAiringTodaySeriesBloc mockAiringTodaySeriesBloc;

  setUp(() {
    mockAiringTodaySeriesBloc = MockAiringTodaySeriesBloc();
    registerFallbackValue(AiringTodaySeriesEventFake());
    registerFallbackValue(AiringTodaySeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodaySeriesBloc>(
      create: (_) => mockAiringTodaySeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockAiringTodaySeriesBloc.state)
        .thenReturn(AiringTodaySeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const AiringTodaySeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockAiringTodaySeriesBloc.state)
        .thenReturn(AiringTodaySeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const AiringTodaySeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockAiringTodaySeriesBloc.state)
        .thenReturn(const AiringTodaySeriesError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const AiringTodaySeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
