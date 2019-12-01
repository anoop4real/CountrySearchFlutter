import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_country_picker/country.dart';
import 'package:country_search/countryDetails.dart';
import 'package:iso_countries/iso_countries.dart';

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
  List<Country> countries;
  List<Country> filteredCountries;
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

  @override
  void initState() {
    // TODO: implement initState
    prepareDefaultCountries();
    super.initState();
  }
  void OnTap(Country item) {
    print(item);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryDetails(selectedCountry: item)));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> prepareDefaultCountries() async {
    List<Country> countries;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = null;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      this.countries = countries;
      filteredCountries =  countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
          itemCount: filteredCountries != null ? filteredCountries.length : 0,
          itemBuilder: (context, index) {
            final country = filteredCountries[index];

            return ListTile(
              title: Text(country.name),
              subtitle: Text(country.countryCode),
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
