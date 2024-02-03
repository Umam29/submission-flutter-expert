import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/network.dart';

class NetworkModel extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const NetworkModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };

  Network toEntity() {
    return Network(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
