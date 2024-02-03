import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final dynamic posterPath;
  final int seasonNumber;
  final double voteAverage;

  const Season({
    this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
