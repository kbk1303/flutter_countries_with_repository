import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/data-access-layer/database/country_db_interface.dart';

import '../data-access-layer/models/models.dart';

abstract class ICountryRepository {
  @visibleForTesting
  ICountryDB get database;
  @visibleForTesting
  set database(ICountryDB db);
  Future<List<Country>>? selectAll();
  Future<Country?> select(int id);
  Future<void>? create(Country? country);
  Future<Country?> update(Country? country);
  Future<void>? delete(int id);
}
