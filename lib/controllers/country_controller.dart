import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/repositories/repositories.dart';

import '../data-access-layer/models/models.dart';

class CountryController {
  late final ICountryRepository? _repo;
  @visibleForTesting
  set repository(ICountryRepository? value) => _repo = value;
  @visibleForTesting
  ICountryRepository? get repository => _repo;

  CountryController({required ICountryRepository? repository})
      : _repo = repository;

  @visibleForTesting
  CountryController.empty();

  Future<List<Country>>? getAllCountries() {
    return _repo?.selectAll();
  }

  Future<Country?>? getCountryById(int? id) {
    return _repo?.select(id);
  }

  Future<Country?>? updateCountry(Country? country) {
    return _repo?.update(country);
  }

  Future<void>? deleteCountry(int? id) {
    return _repo?.delete(id);
  }

  Future<void>? createCountry(Country? country) {
    return _repo?.create(country);
  }
}
