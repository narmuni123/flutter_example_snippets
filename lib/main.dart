import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise_flutter/list/fetch_data_using_scroll_controller.dart';
import 'package:practise_flutter/select_country/country/country_main_screen.dart';
import 'package:provider/provider.dart';

import 'select_country/country_provider/provider_country.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Practise',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blueAccent,
        ),
        home: const CountryMainScreen(),
      ),
    );
  }
}
