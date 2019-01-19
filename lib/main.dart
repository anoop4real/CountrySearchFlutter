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
  bool _IsSearching = false;
  Widget appBarTitle = Text(
    "Search Country",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
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
    return AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (!_IsSearching) {
              this.icon =  Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle =  TextField(
                controller: _controller,
                style:  TextStyle(
                  color: Colors.white,
                ),
                decoration:  InputDecoration(
                    prefixIcon:  Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle:  TextStyle(color: Colors.white)),
                onChanged: searchForText,

              );
              _searchStarted();
            } else {
              _searchEnded();
            }
          });
        },
      ),
    ]);
  }

  void _searchStarted() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _searchEnded() {
    setState(() {
      this.icon = Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
       Text("Search Country", style: TextStyle(color: Colors.white),);
      _IsSearching = false;
      _controller.clear();
      filteredCountries = countries;
    });
  }

  void searchForText(String searchText) {
    setState(() {
      List tempList = List();
      //filteredCountries.map((country) => where(country.name.toLowerCase().contains(searchText.toLowerCase())));
      tempList = countries.where((country) => country.name.toLowerCase().contains(searchText.toLowerCase())).toList();
      filteredCountries = tempList;
    });
  }
}
