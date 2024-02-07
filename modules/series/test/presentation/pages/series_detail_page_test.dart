import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';

class SeriesDetailEventFake extends Fake implements SeriesDetailEvent {}

class SeriesDetailStateFake extends Fake implements SeriesDetailState {}

class MockSeriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class SeriesRecommendationEventFake extends Fake
    implements SeriesRecommendationEvent {}

class SeriesRecommendationStateFake extends Fake
    implements SeriesRecommendationState {}

class MockSeriesRecommendationsBloc
    extends MockBloc<SeriesRecommendationEvent, SeriesRecommendationState>
    implements SeriesRecommendationBloc {}

class WatchlistSeriesEventFake extends Fake implements WatchlistSeriesEvent {}

class WatchlistSeriesStateFake extends Fake implements WatchlistSeriesState {}

class MockWatchlistSeriesBloc
    extends MockBloc<WatchlistSeriesEvent, WatchlistSeriesState>
    implements WatchlistSeriesBloc {}

void main() {
  late MockSeriesDetailBloc mockSeriesDetailBloc;
  late MockSeriesRecommendationsBloc mockSeriesRecommendationsBloc;
  late MockWatchlistSeriesBloc mockWatchlistSeriesBloc;

  setUp(() {
    mockSeriesDetailBloc = MockSeriesDetailBloc();
    mockWatchlistSeriesBloc = MockWatchlistSeriesBloc();
    mockSeriesRecommendationsBloc = MockSeriesRecommendationsBloc();

    registerFallbackValue(SeriesDetailEventFake());
    registerFallbackValue(SeriesDetailStateFake());
    registerFallbackValue(SeriesRecommendationEventFake());
    registerFallbackValue(SeriesRecommendationStateFake());
    registerFallbackValue(WatchlistSeriesEventFake());
    registerFallbackValue(WatchlistSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeriesDetailBloc>(
          create: (context) => mockSeriesDetailBloc,
        ),
        BlocProvider<SeriesRecommendationBloc>(
          create: (context) => mockSeriesRecommendationsBloc,
        ),
        BlocProvider<WatchlistSeriesBloc>(
          create: (context) => mockWatchlistSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => mockSeriesRecommendationsBloc.state)
        .thenReturn(SeriesRecommendationHasData(testSeriesList));
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
        const WatchlistSeriesStatus(false, watchlistRemoveSuccessMessage));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        makeTestableWidget(SeriesDetailPage(id: testSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
        const WatchlistSeriesStatus(true, watchlistAddSuccessMessage));
    when(() => mockSeriesRecommendationsBloc.state)
        .thenReturn(SeriesRecommendationHasData(testSeriesList));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(
        makeTestableWidget(SeriesDetailPage(id: testSeriesDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => mockSeriesRecommendationsBloc.state)
        .thenReturn(SeriesRecommendationHasData(testSeriesList));
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
        const WatchlistSeriesStatus(false, watchlistRemoveSuccessMessage));
    when(() => mockWatchlistSeriesBloc.state).thenReturn(
        const WatchlistSeriesStatus(true, watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(SeriesDetailPage(id: testSeriesDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockSeriesDetailBloc.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => mockSeriesRecommendationsBloc.state)
        .thenReturn(SeriesRecommendationHasData(testSeriesList));
    when(() => mockWatchlistSeriesBloc.state)
        .thenReturn(const WatchlistSeriesStatus(false, 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(SeriesDetailPage(id: testSeriesDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
