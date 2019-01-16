import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:dio/dio.dart';
import 'package:country_search/apiconstants.dart';
import 'package:country_search/countryDataModel.dart';
import 'package:country_search/countryListTile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetails extends StatefulWidget {
  final Country selectedCountry;

  CountryDetails({Key key, @required this.selectedCountry}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryDetailState();
  }
}

class _CountryDetailState extends State<CountryDetails> {
  CountryDataModel countryDetail;

  fetchData() async {
    Dio dio = Dio();
    var url = '$baseURL$codeRoute${widget.selectedCountry.isoCode}';
    Response response = await dio.get(url);

    print(response.data);

    setState(() {
      countryDetail = CountryDataModel.fromJson(response.data);
    });

    print(countryDetail);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (countryDetail == null) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Loading..."),
        ),
      );
    }
    var scaffold = Scaffold(
        appBar: AppBar(
          title: Text('Country Details'),
        ),
        body: Builder(
          builder: (context) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: 300,
                      child: SvgPicture.network(
                        countryDetail.flag,
                        placeholderBuilder: (BuildContext context) =>
                            new Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    CountryListTile(countryDetail.data),
                  ],
                ),
              ),
        ));
    return scaffold;
  }
}
