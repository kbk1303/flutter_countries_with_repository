import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized();
  group('Testing the countries app', () {
    testWidgets('Testing add new countries', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      //expect(find.byKey(const Key('addCountry')), findsOneWidget);
      // add 10 different countries
      for (int i = 0; i < 10; i++) {
        await widgetTester.enterText(
            find.widgetWithText(TextFormField, 'Name'), 'Danmark');
        await widgetTester.enterText(
            find.widgetWithText(TextFormField, 'Flag'), 'Dansk flag ${i + 1}');
        await widgetTester.enterText(find.widgetWithText(TextFormField, 'Area'),
            '${12345 * (10 * i + 1)}');
        await widgetTester.enterText(
            find.widgetWithText(TextFormField, 'Population'),
            '${56789 * (10 * i + 1)}');
        await widgetTester.enterText(
            find.widgetWithText(TextFormField, 'Wiki URL'),
            'https://da.wikipedia.org/wiki/Danmark${i + 1}');
        await widgetTester.ensureVisible(find.byKey(const Key('addCountry')));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byKey(const Key('addCountry')));
        await widgetTester.pumpAndSettle();
      }
      //test the scroll for the entire app
      await widgetTester.fling(
        find.byKey(const ValueKey('scrollView_vertical')),
        const Offset(0, 1500),
        3000,
      );
      await widgetTester.pumpAndSettle();
      await widgetTester.fling(
        find.byKey(const ValueKey('scrollView_vertical')),
        const Offset(0, -1500),
        3000,
      );
      await widgetTester.pumpAndSettle();
      //test scroll for the countries listview
      await widgetTester.fling(
          find.byKey(const ValueKey('scrollView_horizontal')),
          const Offset(-500, 0),
          3000);
      await widgetTester.pumpAndSettle();
      expect(find.byType(IconButton), findsNWidgets(10));
      await widgetTester.pumpAndSettle();
      //delete the fif'th row (id = 5)
      await widgetTester.tap(find.byKey(const ValueKey('deleteCountry_5')));
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(IconButton), findsNWidgets(9));
      await widgetTester.pumpAndSettle();
    });
  });
}
