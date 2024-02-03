import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/spoken_language.dart';

class SpokenLanguageModel extends Equatable {
  final String englishName;
  final String iso6391;
  final String name;

  const SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
