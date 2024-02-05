import 'package:series/data/models/series_table.dart';
import 'package:series/domain/entities/network.dart';
import 'package:series/domain/entities/production_country.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/entities/genre.dart';
import 'package:series/domain/entities/spoken_language.dart';
import 'package:series/domain/entities/t_episode_to_air.dart';

final testSeries = Series(
  adult: false,
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  genreIds: const [16, 18, 10765, 10759],
  id: 94605,
  originCountry: const ["US"],
  originalLanguage: "en",
  originalName: "Arcane",
  overview:
      "Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.",
  popularity: 252.983,
  posterPath: "/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg",
  firstAirDate: "2021-11-06",
  name: "Arcane",
  voteAverage: 8.745,
  voteCount: 3565,
);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  createdBy: const [
    {
      "id": 1190517,
      "credit_id": "5253483c19c29579400de990",
      "name": "Michael Dante DiMartino",
      "gender": 2,
      "profile_path": "/8ey06cRWYe5TlKl5tyYQf57kknw.jpg"
    }
  ],
  episodeRunTime: const [
    {
      "id": 1190517,
      "credit_id": "5253483c19c29579400de990",
      "name": "Michael Dante DiMartino",
      "gender": 2,
      "profile_path": "/8ey06cRWYe5TlKl5tyYQf57kknw.jpg"
    }
  ],
  firstAirDate: DateTime.parse('2024-01-23'),
  genres: const [Genre(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  inProduction: false,
  languages: const ['en'],
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
  networks: const [
    Network(
      id: 1,
      logoPath: 'logoPath',
      name: 'name',
      originCountry: 'originCountry',
    )
  ],
  numberOfEpisodes: 100,
  numberOfSeasons: 2,
  originCountry: const [],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  productionCompanies: const [
    Network(
      id: 1,
      logoPath: 'logoPath',
      name: 'name',
      originCountry: 'originCountry',
    )
  ],
  productionCountries: const [
    ProductionCountry(
      iso31661: 'iso31661',
      name: 'name',
    )
  ],
  seasons: const [
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

const testSeriesTable = SeriesTable(
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
