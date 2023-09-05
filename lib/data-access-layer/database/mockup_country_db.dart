import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/data-access-layer/database/country_db_interface.dart';

/// This class is a singleton class

class MockupCountryDB implements ICountryDB {
  final List<Map<String, dynamic>?> _items = [];
  @visibleForTesting
  List<Map<String, dynamic>?> get items => _items;
  static final MockupCountryDB _db = MockupCountryDB._privateContructor();

  MockupCountryDB._privateContructor();

  factory MockupCountryDB() {
    return _db;
  }

  //singleton methods
  @override
  Future<void> create(Map<String, dynamic>? item) async {
    item?['id'] = _items.length + 1;
    _items.add(item);
  }

  @override
  Future<void> deleteAll() async {
    _items.clear();
  }

  @override
  Future<void> delete(int? id) async {
    _items.removeWhere((item) => item?['id'] == id);
  }

  @override
  Future<List<Map<String, dynamic>?>> selectAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _items;
  }

  @override
  Future<Map<String, dynamic>?> select(int? id) async {
    return _items.firstWhere((item) => item?['id'] == id, orElse: () => null);
  }

  @override
  Future<Map<String, dynamic>?> update(Map<String, dynamic> item) async {
    await Future.delayed(const Duration(milliseconds: 450));
    var updateItem = select(item['id']);
    updateItem.then((value) async {
      value?['name'] =
          value['name'] != item['name'] ? item['name'] : value['name'];
      value?['population'] = value['population'] != item['population']
          ? item['population']
          : value['population'];
      value?['area'] =
          value['area'] != item['area'] ? item['area'] : value['area'];
      //remove the old entry
      await delete(item['id']);
      //insert the updated item
      await create(value);
    });
    //

    //
    return updateItem;
  }
}
