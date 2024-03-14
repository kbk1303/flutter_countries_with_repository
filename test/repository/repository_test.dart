import 'package:flutter_countries_with_repository/data-access-layer/database/database.dart';
import 'package:flutter_countries_with_repository/data-access-layer/models/country.dart';
import 'package:flutter_countries_with_repository/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing the repository', () {
    var repository = CountryRepository.empty();
    repository.database = MockupCountryDB();

    test('create a new country from ctor', () async {
      repository.create(Country(
          id: -1,
          name: 'Denmark',
          flag: 'DK-01',
          area: 123456,
          population: 6000000,
          wikiURL: 'https://somthing.com/denmark'));
      Country? c = await repository.select(1);
      expect(c, isNotNull);
      expect(c?.name, 'Denmark');
    });

    test('create a new Country from factory fromJSON', () async => {});

    test('Update a country name', () async {
      repository.create(Country(
          id: 1,
          name: 'Denmark',
          flag: 'DK-01',
          area: 123456,
          population: 6000000,
          wikiURL: 'https://something.com/denmark'));
      Country? c = await repository.select(1);
      expect(c, isNot(isNull));
      Country cc = Country(
          id: c?.id,
          area: c?.area,
          name: 'Danmark',
          flag: c?.flag,
          population: c?.population,
          wikiURL: c?.wikiURL);
      expect(cc, isNotNull);
      var ccc = await repository.update(cc);
      expect(ccc, isNotNull);
      expect(ccc?.name, 'Danmark');
    });
  });
}
