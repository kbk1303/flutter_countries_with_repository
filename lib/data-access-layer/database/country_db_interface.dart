abstract class ICountryDB {
  Future<void> create(Map<String, dynamic>? item);
  Future<void> deleteAll();
  Future<void> delete(int id);
  Future<List<Map<String, dynamic>?>> selectAll();
  Future<Map<String, dynamic>?> select(int id);
  Future<Map<String, dynamic>?> update(Map<String, dynamic> item);
}
