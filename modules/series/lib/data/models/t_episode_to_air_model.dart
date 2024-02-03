import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/t_episode_to_air.dart';

class TEpisodeToAirModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final DateTime airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final dynamic stillPath;

  const TEpisodeToAirModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory TEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      TEpisodeToAirModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
      };

  TEpisodeToAir toEntity() {
    return TEpisodeToAir(
      id: id,
      name: name,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        voteAverage,
        voteCount,
        airDate,
        episodeNumber,
        episodeType,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
      ];
}
