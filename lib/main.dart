import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:country_search/countryDetails.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => MyApp(),
      },
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Country> countries = Country.ALL;
  List<Country> filteredCountries = Country.ALL;
  final TextEditingController _controller = TextEditingController();
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  bool _IsSearching;
  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  void OnTap(Country item) {
    print(item);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryDetails(selectedCountry: item)));
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
          itemCount: filteredCountries.length,
          itemBuilder: (context, index) {
            final country = filteredCountries[index];

            return ListTile(
              title: Text(country.name),
              subtitle: Text(country.isoCode),
              onTap: () => OnTap(country),
            );
          }),
    );
    return MaterialApp(
      home: scaffold,
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Search Sample", style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      _controller.clear();
      filteredCountries = countries;
    });
  }

  void searchOperation(String searchText) {
    setState(() {
      List tempList = new List();
      //filteredCountries.map((country) => where(country.name.toLowerCase().contains(searchText.toLowerCase())));
      tempList = countries.where((country) => country.name.toLowerCase().contains(searchText.toLowerCase())).toList();
      filteredCountries = tempList;
    });
  }
}

/*

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final List<Country> countries = Country.ALL;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Country Search'),
      ),
      body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];

            return ListTile(
              title: Text(country.name),
              subtitle: Text(country.isoCode),
            );
          }),
    );
    return MaterialApp(
      home: scaffold,
    );
  }
}
*/
