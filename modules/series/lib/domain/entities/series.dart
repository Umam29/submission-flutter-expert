import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Series extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  final int id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  final String? overview;
  double? popularity;
  final String? posterPath;
  String? firstAirDate;
  final String? name;
  double? voteAverage;
  int? voteCount;

  Series({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  Series.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount
      ];
}
