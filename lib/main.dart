import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Provider/financeProvider.dart';
import 'package:untitled/constants.dart';

import 'Screens/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FinanceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(color: primaryColor),
          listTileTheme: ListTileThemeData(
            textColor: secondaryColor,
          ),
          textTheme: TextTheme(
            labelLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
           labelSmall: TextStyle(
             fontSize: 16,
             color: secondaryColor,
             fontWeight: FontWeight.bold
           ),
           labelMedium: TextStyle(
             color: Colors.white
           )
          )
        ),
        home: Dashboard(),
      ),
    );
  }
}
