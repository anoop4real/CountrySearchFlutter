import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:country_search/countryDetails.dart';

class CountryListTile extends StatelessWidget {
  Map<String, dynamic> country;

  CountryListTile(this.country);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: country.length,
          itemBuilder: (context, index) {
            String key = country.keys.elementAt(index);

            return Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                Text('$key : '),
                Text(country[key].toString())
              ],
            );
          }),
    );
  }
}
