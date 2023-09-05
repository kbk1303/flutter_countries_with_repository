import 'dart:convert';

import 'package:flutter_countries_with_repository/data-access-layer/models/country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing Country model', () {
    test('Country to map', () {
      var country = Country(
          id: 0,
          name: 'Denmark',
          area: 1234567,
          population: 670000000,
          flag: 'DK-01',
          wikiURL: 'https://wikiurl.com/denmark');
      var map = country.toMap();
      expect(map, isNotNull);
      expect(map['id'], 0);
      expect(map['name'], isA<String>());
      expect(map['population'], isA<int>());
      expect(map['area'], 1234567);
    });

    test('Country from map', () {
      var country = Country.fromMap(createRandomCountryData());
      expect(country, isNotNull);
      expect(country.id, isA<int>());
      expect(country.name, 'Germany');
    });

    test('Country to JSON', () {
      var country = Country.fromMap(createRandomCountryData());
      var jsonObj = country.toJson();
      expect(jsonObj, isNotNull);
      var json = jsonDecode(jsonObj);
      expect(json, isNotNull);
      expect(json['id'], 5);
    });
  });
}

Map<String, dynamic> createRandomCountryData() {
  var map = <String, dynamic>{};
  map.addAll({'id': 5});
  map.addAll({'name': 'Germany'});
  map.addAll({'population': 5545454545454});
  map.addAll({'area': 23231134565676});
  map.addAll({'flag': 'GE-02'});
  map.addAll({'wikiURL': 'https://wikiurl.com/germany'});
  return map;
}
