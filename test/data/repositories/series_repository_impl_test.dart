import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/data/models/genre_model.dart';
import 'package:series/data/models/network_model.dart';
import 'package:series/data/models/production_country_model.dart';
import 'package:series/data/models/season_model.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/spoken_language_model.dart';
import 'package:series/data/models/t_episode_to_air_model.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesRemoteDataSource mockSeriesRemoteDataSource;
  late MockSeriesLocalDataSource mockSeriesLocalDataSource;

  setUp(() {
    mockSeriesRemoteDataSource = MockSeriesRemoteDataSource();
    mockSeriesLocalDataSource = MockSeriesLocalDataSource();
    repository = SeriesRepositoryImpl(
      remoteDataSource: mockSeriesRemoteDataSource,
      localDataSource: mockSeriesLocalDataSource,
    );
  });

  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: '/aRKQdF6AGbhnF9IAyJbte5epH5R.jpg',
    genreIds: [
      10759,
      10765,
    ],
    id: 111110,
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'One Piece',
    overview:
        'With his straw hat and ragtag crew, young pirate Monkey D. Luffy goes on an epic voyage for treasure.',
    popularity: 208.288,
    posterPath: '/rVX05xRKS5JhEYQFObCi4lAnZT4.jpg',
    firstAirDate: '2023-08-31',
    name: 'ONE PIECE',
    voteAverage: 8.2,
    voteCount: 902,
  );

  final tSeries = Series(
    adult: false,
    backdropPath: '/aRKQdF6AGbhnF9IAyJbte5epH5R.jpg',
    genreIds: [
      10759,
      10765,
    ],
    id: 111110,
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'One Piece',
    overview:
        'With his straw hat and ragtag crew, young pirate Monkey D. Luffy goes on an epic voyage for treasure.',
    popularity: 208.288,
    posterPath: '/rVX05xRKS5JhEYQFObCi4lAnZT4.jpg',
    firstAirDate: '2023-08-31',
    name: 'ONE PIECE',
    voteAverage: 8.2,
    voteCount: 902,
  );

  final tSeriesModelList = <SeriesModel>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];

  group('Airing Today Series', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(mockSeriesRemoteDataSource.getAiringTodaySeries())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getAiringTodaySeries();

        verify(mockSeriesRemoteDataSource.getAiringTodaySeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockSeriesRemoteDataSource.getAiringTodaySeries())
          .thenThrow(ServerException());

      final result = await repository.getAiringTodaySeries();

      verify(mockSeriesRemoteDataSource.getAiringTodaySeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockSeriesRemoteDataSource.getAiringTodaySeries())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getAiringTodaySeries();

      verify(mockSeriesRemoteDataSource.getAiringTodaySeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Series', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(mockSeriesRemoteDataSource.getPopularSeries())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getPopularSeries();

        verify(mockSeriesRemoteDataSource.getPopularSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockSeriesRemoteDataSource.getPopularSeries())
          .thenThrow(ServerException());

      final result = await repository.getPopularSeries();

      verify(mockSeriesRemoteDataSource.getPopularSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockSeriesRemoteDataSource.getPopularSeries())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getPopularSeries();

      verify(mockSeriesRemoteDataSource.getPopularSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Series', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(mockSeriesRemoteDataSource.getTopRatedSeries())
            .thenAnswer((_) async => tSeriesModelList);

        final result = await repository.getTopRatedSeries();

        verify(mockSeriesRemoteDataSource.getTopRatedSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockSeriesRemoteDataSource.getTopRatedSeries())
          .thenThrow(ServerException());

      final result = await repository.getTopRatedSeries();

      verify(mockSeriesRemoteDataSource.getTopRatedSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockSeriesRemoteDataSource.getTopRatedSeries())
          .thenThrow(SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedSeries();

      verify(mockSeriesRemoteDataSource.getTopRatedSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Series Detail', () {
    final tId = 1;
    final tSeriesDetail = SeriesDetailModel(
      adult: false,
      backdropPath: 'backdropPath',
      createdBy: [
        {
          "id": 1190517,
          "credit_id": "5253483c19c29579400de990",
          "name": "Michael Dante DiMartino",
          "gender": 2,
          "profile_path": "/8ey06cRWYe5TlKl5tyYQf57kknw.jpg"
        }
      ],
      episodeRunTime: [
        {
          "id": 1190517,
          "credit_id": "5253483c19c29579400de990",
          "name": "Michael Dante DiMartino",
          "gender": 2,
          "profile_path": "/8ey06cRWYe5TlKl5tyYQf57kknw.jpg"
        }
      ],
      firstAirDate: DateTime.parse('2024-01-23'),
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      inProduction: false,
      languages: ['en'],
      name: 'name',
      nextEpisodeToAir: TEpisodeToAirModel(
        id: 1,
        name: "name",
        overview: "overview",
        voteAverage: 1,
        voteCount: 1,
        airDate: DateTime.parse('2024-01-29'),
        episodeNumber: 1,
        episodeType: "episodeType",
        productionCode: "productionCode",
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: "stillPath",
      ),
      networks: [
        NetworkModel(
          id: 1,
          logoPath: 'logoPath',
          name: 'name',
          originCountry: 'originCountry',
        )
      ],
      numberOfEpisodes: 100,
      numberOfSeasons: 2,
      originCountry: [],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      productionCompanies: [
        NetworkModel(
          id: 1,
          logoPath: 'logoPath',
          name: 'name',
          originCountry: 'originCountry',
        )
      ],
      productionCountries: [
        ProductionCountryModel(
          iso31661: 'iso31661',
          name: 'name',
        )
      ],
      seasons: [
        SeasonModel(
          episodeCount: 100,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 2,
          voteAverage: 1,
        )
      ],
      spokenLanguages: [
        SpokenLanguageModel(
          englishName: 'englishName',
          iso6391: 'iso6391',
          name: 'name',
        )
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenAnswer((_) async => tSeriesDetail);
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Series Recommendations', () {
    final tSeriesList = <SeriesModel>[];
    final tId = 1;

    test('should return data (series list) when the call is successful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getRecommendation(tId))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getRecommendation(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getRecommendation(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendation(tId);
      // assertbuild runner
      verify(mockSeriesRemoteDataSource.getRecommendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.getRecommendation(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getRecommendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Series', () {
    final tQuery = 'avatar';

    test('should return series list when call to data source is successful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchListSeries(testSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchListSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchListSeries(testSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchListSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockSeriesLocalDataSource.getBySeriesId(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist series', () {
    test('should return list of Series', () async {
      // arrange
      when(mockSeriesLocalDataSource.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesTable]);
      // act
      final result = await repository.getWatchlistSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });
  });
}
