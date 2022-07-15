import 'package:flutter/material.dart';
import 'package:practise_flutter/select_country/model_country/country_model.dart';


class CountryMainScreen extends StatefulWidget {
  static const String title = 'Select Countries';

  const CountryMainScreen({Key? key}) : super(key: key);

  @override
  _CountryMainScreenState createState() => _CountryMainScreenState();
}

class _CountryMainScreenState extends State<CountryMainScreen> {

  Country? country;
  List<Country> countries = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
