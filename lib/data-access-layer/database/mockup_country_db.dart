/// This class is a singleton class

class MockupCountryDB {
  final List<Map<String, dynamic>?> _items = [];
  static final MockupCountryDB _db = MockupCountryDB._privateContructor();

  MockupCountryDB._privateContructor();

  factory MockupCountryDB() {
    return _db;
  }

  //singleton methods
  Future<void> create(Map<String, dynamic>? item) async {
    item?['id'] = _items.length + 1;
    _items.add(item);
  }

  Future<void> delete(int id) async {
    _items.removeWhere((item) => item?['id'] == id);
  }

  Future<List<Map<String, dynamic>?>> selectAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _items;
  }

  Future<Map<String, dynamic>?> select(int id) async {
    return _items.firstWhere((item) => item?['id'] == id, orElse: () => null);
  }

  Future<Map<String, dynamic>?> update(Map<String, dynamic> item) async {
    await Future.delayed(const Duration(milliseconds: 450));
    var updateItem = select(item['id']);
    updateItem.then((value) {
      value?['name'] =
          value['name'] != item['name'] ? item['name'] : value['name'];
      value?['population'] = value['population'] != item['population']
          ? item['population']
          : value['population'];
      value?['area'] =
          value['area'] != item['area'] ? item['area'] : value['area'];
      //remove the old entry
      delete(item['id']);
      //insert the updated item
      create(value);
    });
    //

    //
    return updateItem;
  }
}
