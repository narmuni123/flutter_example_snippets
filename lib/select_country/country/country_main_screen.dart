import 'package:flutter/material.dart';
import 'package:practise_flutter/select_country/country/country_screen.dart';
import 'package:practise_flutter/select_country/country_widgets/flag_widget_country.dart';
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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).primaryColor,
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSingleCountry(),
          const SizedBox(height: 24),
          buildMultipleCountry(),
        ],
      ),
    ),
  );

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CountryPage()),
      );

      if (country == null) return;

      setState(() => this.country = country);
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null
          ? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: country!.name,
        leading: FlagWidget(code: country!.code),
        onTap: onTap,
      ),
    );
  }

  Widget buildMultipleCountry() {
    final countriesText = countries.map((country) => country.name).join(', ');
    final onTap = () async {
      final countries = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryPage(
              isMultiSelection: true,
              countries: List.of(this.countries),
            )),
      );

      if (countries == null) return;

      setState(() => this.countries = countries);
    };

    return buildCountryPicker(
      title: 'Select Countries',
      child: countries.isEmpty
          ? buildListTile(title: 'No Countries', onTap: onTap)
          : buildListTile(title: countriesText, onTap: onTap),
    );
  }

  Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}