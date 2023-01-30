import '../data-access-layer/models/models.dart';

abstract class ICountryRepository {
  Future<List<Country>>? selectAll();
  Future<Country?> select(int id);
  Future<void> create(Country? country);
  Future<Country?> update(Country? country);
  Future<void> delete(int id);
}
