// Create a mock for your CountryController
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countries_with_repository/controllers/country_controller.dart';
import 'package:flutter_countries_with_repository/data-access-layer/database/mockup_country_db.dart';
import 'package:flutter_countries_with_repository/data-access-layer/models/country.dart';
import 'package:flutter_countries_with_repository/main.dart';
import 'package:flutter_countries_with_repository/repositories/country_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCountryController extends Mock implements CountryController {}

class MockCountryRepository extends Mock implements CountryRepository {}

class MockDatabase extends Mock implements MockupCountryDB {}

void main() {
  MockCountryController? mockController;

  setUp(() {
    mockController = MockCountryController();
    mockController?.repository = MockCountryRepository();
    mockController?.repository?.database = MockDatabase();
  });

  testWidgets('The loading should be  shown initialy', (widgetTester) async {
    // Make sure mockController is initialized
    if (mockController == null) {
      fail("mockController is null");
    }
    // Mock the getAllCountries method to return an uncompleted Future
    when(mockController!.getAllCountries())
        .thenAnswer((_) => Completer<List<Country>>().future);

    // Build our app and trigger a frame.
    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(body: HomePage(controller: mockController!)),
    ));

    // Let's pump a frame to start the FutureBuilder
    await widgetTester.pump();

    // Verify if the Loading.. text shows up
    expect(find.text('Loading..'), findsOneWidget);
  });

  testWidgets('Testing data input', (WidgetTester tester) async {
    if (mockController == null) {
      fail("mockController is null");
    }

    // Dummy data
    final Country dummyCountry = Country(
      id: 1,
      name: 'Danmark',
      flag: 'Dansk flag',
      area: 12345,
      population: 56789,
      wikiURL: 'https://da.wikipedia.org/wiki/Danmark',
    );

    when(mockController?.createCountry(dummyCountry))
        .thenAnswer((_) => Completer<void>().future);

    when(mockController?.getAllCountries())
        .thenAnswer((_) async => [dummyCountry]);

    // Byg vores app og udløs en frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: HomePage(controller: mockController!)),
    ));

    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'), 'Danmark');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Flag'), 'Dansk flag');
    await tester.enterText(find.widgetWithText(TextFormField, 'Area'), '12345');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Population'), '56789');
    await tester.enterText(find.widgetWithText(TextFormField, 'Wiki URL'),
        'https://da.wikipedia.org/wiki/Danmark');

    // Find og tryk på "Add Country" knappen
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Country'));
    await tester.pumpAndSettle();

    // Forvent, at det nye land vises i _CountryTable

    /** Ikke længere brugbar efter name i tabellen er blevet redigerbar. 
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TextFormField && (widget).controller?.text == 'Danmark'),
        findsOneWidget);
    */

    expect(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField &&
            (widget).key != const ValueKey('table_name_1') &&
            (widget).controller?.text == 'Danmark'),
        findsOneWidget);

    expect(find.byKey(const ValueKey('table_name_1')), findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == 'Dansk flag'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == '12345'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == '56789'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            (widget).data == 'https://da.wikipedia.org/wiki/Danmark'),
        findsOneWidget);
  });

  testWidgets('Update country data', (tester) async {
    if (mockController == null) {
      fail("mockController is null");
    }
    // Dummy data
    final Country dummyCountry = Country(
      id: 1,
      name: 'Denmark',
      flag: 'Dansk flag',
      area: 12345,
      population: 56789,
      wikiURL: 'https://da.wikipedia.org/wiki/Danmark',
    );

    when(mockController?.createCountry(dummyCountry))
        .thenAnswer((_) => Completer<void>().future);

    when(mockController?.getAllCountries())
        .thenAnswer((_) async => [dummyCountry]);

    // Byg vores app og udløs en frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: HomePage(controller: mockController!)),
    ));

    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'), 'Denmark');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Flag'), 'Dansk flag');
    await tester.enterText(find.widgetWithText(TextFormField, 'Area'), '12345');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Population'), '56789');
    await tester.enterText(find.widgetWithText(TextFormField, 'Wiki URL'),
        'https://da.wikipedia.org/wiki/Danmark');

    // Find og tryk på "Add Country" knappen
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Country'));
    await tester.pumpAndSettle();

    // Forvent, at det nye land vises i _CountryTable

    /** Ikke længere brugbar efter name i tabellen er blevet redigerbar. 
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TextFormField && (widget).controller?.text == 'Danmark'),
        findsOneWidget);
    */

    expect(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField &&
            (widget).key != const ValueKey('table_name_1') &&
            (widget).controller?.text == 'Denmark'),
        findsOneWidget);

    expect(find.byKey(const ValueKey('table_name_1')), findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == 'Dansk flag'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == '12345'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == '56789'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            (widget).data == 'https://da.wikipedia.org/wiki/Danmark'),
        findsOneWidget);

    reset(mockController); // IMPORTANT!! Must be reset before redefining the mock

    Country updateCountry = Country(
        id: dummyCountry.id,
        name: 'UAE',
        flag: dummyCountry.flag,
        area: dummyCountry.area,
        population: dummyCountry.population,
        wikiURL: dummyCountry.wikiURL);

    //and update the country
    when(mockController?.updateCountry(updateCountry))
        .thenAnswer((_) async => updateCountry);

    when(mockController?.getAllCountries()).thenAnswer((_) async {
      List<Country> countries = [updateCountry];
      debugPrint('countries from getAllCountries: $countries');
      return countries;
    });

    await tester.pumpAndSettle();

    //update the name in the table
    await tester.tap(find.byKey(const ValueKey('table_name_1')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('table_name_1')), 'UAE');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    verify(mockController?.updateCountry(updateCountry)).called(1);

    expect(updateCountry.name == 'UAE', isTrue);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    var captured = verify(mockController?.getAllCountries()).captured;
    debugPrint("Captured: $captured");

    //verify(mockController?.getAllCountries()).called(1);

    debugPrint(
        'value in testcase: ${(find.byKey(const ValueKey('table_name_1')).evaluate().first.widget as TextFormField).controller?.text}');

    expect(
        find.byWidgetPredicate((widget) =>
            widget is TextFormField &&
            (widget).key == const ValueKey('table_name_1') &&
            (widget).controller?.text == 'UAE'),
        findsOneWidget);
  });
}
