import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/series/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/series/network.dart';
import 'package:ditonton/domain/entities/series/production_country.dart';
import 'package:ditonton/domain/entities/series/season.dart';
import 'package:ditonton/domain/entities/series/series.dart';
import 'package:ditonton/domain/entities/series/series_detail.dart';
import 'package:ditonton/domain/entities/series/spoken_language.dart';
import 'package:ditonton/domain/entities/series/t_episode_to_air.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSeries = Series(
  adult: false,
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  genreIds: [16, 18, 10765, 10759],
  id: 94605,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Arcane",
  overview:
      "Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.",
  popularity: 252.983,
  posterPath: "/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg",
  firstAirDate: DateTime.parse("2021-11-06"),
  name: "Arcane",
  voteAverage: 8.745,
  voteCount: 3565,
);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
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
  genres: [Genre(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  inProduction: false,
  languages: ['en'],
  name: 'name',
  nextEpisodeToAir: TEpisodeToAir(
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
    Network(
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
    Network(
      id: 1,
      logoPath: 'logoPath',
      name: 'name',
      originCountry: 'originCountry',
    )
  ],
  productionCountries: [
    ProductionCountry(
      iso31661: 'iso31661',
      name: 'name',
    )
  ],
  seasons: [
    Season(
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
    SpokenLanguage(
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

final testSeriesTable = SeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistSeries = Series.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
