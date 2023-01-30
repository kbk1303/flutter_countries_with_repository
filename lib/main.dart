import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countries_with_repository/controllers/controllers.dart';
import 'package:flutter_countries_with_repository/data-access-layer/models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Country repo demo"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final CountryController controller = CountryController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      _Form(widget.controller, () => _refreshList()),
      _CountryTable(widget.controller, () => _refreshList()),
    ]);
  }
}

class _Form extends StatefulWidget {
  final CountryController _controller;
  final VoidCallback _refreshList;

  const _Form(this._controller, this._refreshList);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _flagFieldController = TextEditingController();
  final TextEditingController _areaFieldController = TextEditingController();
  final TextEditingController _populationFieldController =
      TextEditingController();
  final TextEditingController _wikiUrlFieldController = TextEditingController();

  @override
  void dispose() {
    _nameFieldController.dispose();
    _flagFieldController.dispose();
    _areaFieldController.dispose();
    _populationFieldController.dispose();
    _wikiUrlFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameFieldController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter country name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _flagFieldController,
              decoration: const InputDecoration(
                labelText: 'Flag',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide the flags wiki location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _areaFieldController,
              decoration: const InputDecoration(
                labelText: 'Area',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
              ],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the area';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _populationFieldController,
              decoration: const InputDecoration(
                labelText: 'Population',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
              ],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the population';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _wikiUrlFieldController,
              decoration: const InputDecoration(
                labelText: 'Wiki URL',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide the top-level wiki url';
                }
                return null;
              },
            ),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget._controller.createCountry(Country(
                          id: 0,
                          name: _nameFieldController.text,
                          flag: _flagFieldController.text,
                          area: int.parse(_areaFieldController.text),
                          population:
                              int.parse(_populationFieldController.text),
                          wikiURL: _wikiUrlFieldController.text));
                      widget._refreshList();
                    }
                  },
                  child: const Text('Add Country'),
                )),
          ],
        ),
      ),
    );
  }
}

class _CountryTable extends StatelessWidget {
  final CountryController _controller;
  final VoidCallback _refreshList;

  const _CountryTable(this._controller, this._refreshList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Country>>(
        future: _controller.getAllCountries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading..'));
          } else {
            return DataTable(
                columns: _createCountryTableColumns(),
                rows: _createCountryTableRows(snapshot.data ?? []));
          }
        });
  }

  List<DataColumn> _createCountryTableColumns() {
    return [
      const DataColumn(label: Text('Name')),
      const DataColumn(label: Text('Flag')),
      const DataColumn(label: Text('Area')),
      const DataColumn(label: Text('Population')),
      const DataColumn(label: Text('Wiki URL')),
      const DataColumn(label: Text('Delete')),
    ];
  }

  List<DataRow> _createCountryTableRows(List<Country> countries) {
    return countries
        .map((country) => DataRow(cells: [
              DataCell(Text(country.name)),
              DataCell(Text(country.flag)),
              DataCell(Text(country.area.toString())),
              DataCell(Text(country.population.toString())),
              DataCell(Text(country.wikiURL)),
              //DataCell(Text('${book.title} (${book.year.toString()})')),
              DataCell(IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await _controller.deleteCountry(country.id);
                  _refreshList();
                },
              )),
            ]))
        .toList();
  }
}
