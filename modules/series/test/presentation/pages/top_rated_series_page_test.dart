import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';

class TopRatedSeriesEventFake extends Fake implements TopRatedSeriesEvent {}

class TopRatedSeriesStateFake extends Fake implements TopRatedSeriesState {}

class MockTopRatedSeriesBloc
    extends MockBloc<TopRatedSeriesEvent, TopRatedSeriesState>
    implements TopRatedSeriesBloc {}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();
    registerFallbackValue(TopRatedSeriesEventFake());
    registerFallbackValue(TopRatedSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>(
      create: (_) => mockTopRatedSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(const TopRatedSeriesError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
