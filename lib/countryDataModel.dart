class CountryDataModel {
  final Map<String, dynamic> data;
  final String name;
  final String capital;
  final int population;
  final double area;
  final String nativeName;
  final String region;
  final String flag;

  CountryDataModel(
      {this.data,
      this.name,
      this.capital,
      this.population,
      this.area,
      this.nativeName,
      this.region,
      this.flag});

  factory CountryDataModel.fromJson(Map<String, dynamic> json) {
    return CountryDataModel(
      data: {
        'NAME': json['name'],
        'CAPITAL': json['capital'],
        'POPULATION': json['population'],
        'NATIVE NAME': json['nativeName'],
        'AREA': json['area'],
        'REGION': json['region'],
      },
      name: json['name'],
      capital: json['capital'],
      population: json['population'],
      area: json['area'],
      nativeName: json['nativeName'],
      region: json['region'],
      flag: json['flag'],
    );
  }
}
