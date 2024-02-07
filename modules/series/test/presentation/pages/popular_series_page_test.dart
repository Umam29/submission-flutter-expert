import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';

class PopularSeriesEventFake extends Fake implements PopularSeriesEvent {}

class PopularSeriesStateFake extends Fake implements PopularSeriesState {}

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();
    registerFallbackValue(PopularSeriesEventFake());
    registerFallbackValue(PopularSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>(
      create: (_) => mockPopularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(PopularSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(PopularSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(const PopularSeriesError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
