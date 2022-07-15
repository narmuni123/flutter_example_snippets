import 'package:practise_flutter/select_country/model_country/country_model.dart';

class Utils {
  static int ascendingSort(Country c1, Country c2) =>
      c1.name.compareTo(c2.name);
}