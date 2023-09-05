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
          id: 1,
          name: 'Denmark',
          flag: 'DK-01',
          area: 123456,
          population: 6000000,
          wikiURL: 'https://somthing.com/denmark'));
      Country? c = await repository.select(1);
      expect(c, isNot(isNull));
      expect(c?.name, 'Denmark');
    });

    test('create a new Country from factory fromJSON', () async => {});
  });
}
