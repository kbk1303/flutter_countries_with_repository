import 'package:flutter_countries_with_repository/data-access-layer/database/database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('testing the mockup database', () {
    var db = MockupCountryDB();

    test('select item from id', () async {
      var map1 = createMapItems('Holland');
      var map2 = createMapItems('Denmark');
      await db.create(map1);
      await db.create(map2);
      expect(db.items.length, 2);
      Map<String, dynamic>? item = await db.select(2);
      expect(item, isNotNull);
      await db.deleteAll();
    });

    test('Create new items', () async {
      var map1 = createMapItems('Holland');
      var map2 = createMapItems('Denmark');

      await db.create(map1);
      expect(db.items.length, 1);
      var mapItem = db.items.first;
      expect(mapItem, isNotNull);
      expect(mapItem?['id'], db.items.length);
      await db.create(map2);
      expect(db.items.length, 2);
      await db.deleteAll();
      expect(db.items.length, 0);
    });

    test('select the corect Map entry in the list', () async {
      await db.create(createMapItems('France'));
      await db.create(createMapItems('Spain'));
      expect(db.items.length, 2);
      var mapItem = await db.select(2);
      expect(mapItem?['name'], 'Spain');
      await db.deleteAll();
    });
  });
}

Map<String, dynamic> createMapItems(String name) {
  var map = <String, dynamic>{};
  map.addAll({'id': -1});
  map.addAll({'name': name});
  map.addAll({'area': 123342345});
  map.addAll({'population': 34234112133});
  map.addAll({'flag': 'Holland-03'});
  map.addAll({'wikiUrl': 'http://wikiUrl.com/holland'});
  return map;
}
