import 'package:equatable/equatable.dart';
import 'package:series/data/models/genre_model.dart';
import 'package:series/data/models/network_model.dart';
import 'package:series/data/models/production_country_model.dart';
import 'package:series/data/models/season_model.dart';
import 'package:series/data/models/spoken_language_model.dart';
import 'package:series/data/models/t_episode_to_air_model.dart';
import 'package:series/domain/entities/series_detail.dart';

class SeriesDetailModel extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<dynamic> createdBy;
  final List<dynamic> episodeRunTime;
  final DateTime firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime? lastAirDate;
  final TEpisodeToAirModel? lastEpisodeToAir;
  final String name;
  final TEpisodeToAirModel? nextEpisodeToAir;
  final List<NetworkModel> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<NetworkModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final List<SeasonModel> seasons;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const SeriesDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      SeriesDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: List<dynamic>.from(json["created_by"].map((x) => x)),
        episodeRunTime:
            List<dynamic>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: (json["last_air_data"] != null)
            ? DateTime.parse(json["last_air_date"])
            : null,
        lastEpisodeToAir: (json["last_episode_to_air"] != null)
            ? TEpisodeToAirModel.fromJson(json["last_episode_to_air"])
            : null,
        name: json["name"],
        nextEpisodeToAir: (json["next_episode_to_air"] != null)
            ? TEpisodeToAirModel.fromJson(json["next_episode_to_air"])
            : null,
        networks: List<NetworkModel>.from(
            json["networks"].map((x) => NetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<NetworkModel>.from(
            json["production_companies"].map((x) => NetworkModel.fromJson(x))),
        productionCountries: List<ProductionCountryModel>.from(
            json["production_countries"]
                .map((x) => ProductionCountryModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages: List<SpokenLanguageModel>.from(json["spoken_languages"]
            .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x)),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": lastAirDate,
        "last_episode_to_air": lastEpisodeToAir?.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir!.toJson(),
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  SeriesDetail toEntity() {
    return SeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      createdBy: createdBy,
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genres.map((e) => e.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      networks: networks.map((e) => e.toEntity()).toList(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies:
          productionCompanies.map((e) => e.toEntity()).toList(),
      productionCountries:
          productionCountries.map((e) => e.toEntity()).toList(),
      seasons: seasons.map((e) => e.toEntity()).toList(),
      spokenLanguages: spokenLanguages.map((e) => e.toEntity()).toList(),
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
