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

    when(mockController!.createCountry(dummyCountry))
        .thenAnswer((_) => Completer<void>().future);

    when(mockController!.getAllCountries())
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
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && (widget).data == 'Danmark'),
        findsOneWidget);
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
}
