import 'package:flutter_countries_with_repository/data-access-layer/database/mockup_country_db.dart';
import 'package:flutter_countries_with_repository/data-access-layer/models/country.dart';
import 'package:flutter_countries_with_repository/repositories/repositories.dart';

class CountryRepository implements ICountryRepository {
  final MockupCountryDB db;
  CountryRepository(this.db);

  @override
  Future<void> create(Country? country) {
    return db.create(country?.toMap());
  }

  @override
  Future<void> delete(int id) {
    return db.delete(id);
  }

  @override
  Future<Country?> select(int id) async {
    var item = await db.select(id);
    return item != null ? Country.fromMap(item) : null;
  }

  @override
  Future<List<Country>>? selectAll() async {
    var items = await db.selectAll();
    return items.map((item) => Country.fromMap(item ?? item!)).toList();
  }

  @override
  Future<Country?> update(Country? country) async {
    var mapCountry = country?.toMap();
    var updatedCountry = await db.update(mapCountry!);
    return updatedCountry != null ? Country.fromMap(updatedCountry) : null;
  }
}
