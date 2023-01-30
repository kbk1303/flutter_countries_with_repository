import 'dart:convert';

class Country {
  final int id;
  final String name;
  final String flag;
  final int area;
  final int population;
  final String wikiURL;

  Country({
    required this.id,
    required this.name,
    required this.flag,
    required this.area,
    required this.population,
    required this.wikiURL,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'flag': flag});
    result.addAll({'area': area});
    result.addAll({'population': population});
    result.addAll({'wikiURL': wikiURL});

    return result;
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      flag: map['flag'] ?? '',
      area: map['area']?.toInt() ?? 0,
      population: map['population']?.toInt() ?? 0,
      wikiURL: map['wikiURL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  Country copyWith({
    int? id,
    String? name,
    String? flag,
    int? area,
    int? population,
    String? wikiURL,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      flag: flag ?? this.flag,
      area: area ?? this.area,
      population: population ?? this.population,
      wikiURL: wikiURL ?? this.wikiURL,
    );
  }

  @override
  String toString() {
    return 'Country(id: $id, name: $name, flag: $flag, area: $area, population: $population, wikiURL: $wikiURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.id == id &&
        other.name == name &&
        other.flag == flag &&
        other.area == area &&
        other.population == population &&
        other.wikiURL == wikiURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        flag.hashCode ^
        area.hashCode ^
        population.hashCode ^
        wikiURL.hashCode;
  }
}
