import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/data-access-layer/database/country_db_interface.dart';
import 'package:flutter_countries_with_repository/data-access-layer/models/country.dart';
import 'package:flutter_countries_with_repository/repositories/repositories.dart';

class CountryRepository implements ICountryRepository {
  late final ICountryDB _db;
  @override
  @visibleForTesting
  set database(ICountryDB db) => _db = db;
  @override
  @visibleForTesting
  ICountryDB get database => _db;

  CountryRepository({required ICountryDB countryDB}) : _db = countryDB;

  @visibleForTesting
  CountryRepository.empty();

  @override
  Future<void>? create(Country? country) {
    return _db.create(country?.toMap());
  }

  @override
  Future<void>? delete(int id) {
    return _db.delete(id);
  }

  @override
  Future<Country?> select(int id) async {
    var item = await _db.select(id);
    return item != null ? Country.fromMap(item) : null;
  }

  @override
  Future<List<Country>>? selectAll() async {
    var items = await _db.selectAll();
    return items.map((item) => Country.fromMap(item!)).toList();
  }

  @override
  Future<Country?> update(Country? country) async {
    var mapCountry = country?.toMap();
    var updatedCountry = await _db.update(mapCountry!);
    return updatedCountry != null ? Country.fromMap(updatedCountry) : null;
  }
}
