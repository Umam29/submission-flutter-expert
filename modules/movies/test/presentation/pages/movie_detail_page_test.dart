import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MoviesDetailEventFake extends Fake implements MoviesDetailEvent {}

class MoviesDetailStateFake extends Fake implements MoviesDetailState {}

class MockMoviesDetailBloc
    extends MockBloc<MoviesDetailEvent, MoviesDetailState>
    implements MoviesDetailBloc {}

class MoviesRecommendationEventFake extends Fake
    implements MoviesRecommendationEvent {}

class MoviesRecommendationStateFake extends Fake
    implements MoviesRecommendationState {}

class MockMoviesRecommendationsBloc
    extends MockBloc<MoviesRecommendationEvent, MoviesRecommendationState>
    implements MoviesRecommendationBloc {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMoviesEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

void main() {
  late MockMoviesDetailBloc mockMoviesDetailBloc;
  late MockMoviesRecommendationsBloc mockMoviesRecommendationsBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUp(() {
    mockMoviesDetailBloc = MockMoviesDetailBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockMoviesRecommendationsBloc = MockMoviesRecommendationsBloc();

    registerFallbackValue(MoviesDetailEventFake());
    registerFallbackValue(MoviesDetailStateFake());
    registerFallbackValue(MoviesRecommendationEventFake());
    registerFallbackValue(MoviesRecommendationStateFake());
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistMoviesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesDetailBloc>(
          create: (context) => mockMoviesDetailBloc,
        ),
        BlocProvider<MoviesRecommendationBloc>(
          create: (context) => mockMoviesRecommendationsBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => mockWatchlistMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMoviesDetailBloc.state)
        .thenReturn(MoviesDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieStatus(false, watchlistRemoveSuccessMessage));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMoviesDetailBloc.state)
        .thenReturn(MoviesDetailHasData(testMovieDetail));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieStatus(true, watchlistAddSuccessMessage));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMoviesDetailBloc.state)
        .thenReturn(MoviesDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieStatus(false, watchlistRemoveSuccessMessage));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieStatus(true, watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMoviesDetailBloc.state)
        .thenReturn(MoviesDetailHasData(testMovieDetail));
    when(() => mockMoviesRecommendationsBloc.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieStatus(false, 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
