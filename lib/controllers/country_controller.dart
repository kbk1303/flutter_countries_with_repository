import 'package:flutter_countries_with_repository/data-access-layer/database/mockup_country_db.dart';
import 'package:flutter_countries_with_repository/repositories/repositories.dart';

import '../data-access-layer/models/models.dart';

class CountryController {
  final ICountryRepository repo = CountryRepository(MockupCountryDB());

  Future<List<Country>>? getAllCountries() {
    return repo.selectAll();
  }

  Future<Country?> getCountryById(int id) {
    return repo.select(id);
  }

  Future<Country?> updateCountry(Country? country) {
    return repo.update(country);
  }

  Future<void> deleteCountry(int id) {
    return repo.delete(id);
  }

  Future<void> createCountry(Country? country) {
    return repo.create(country);
  }
}
