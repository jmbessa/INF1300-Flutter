import 'package:flutter/material.dart';
import 'package:services_app/workers.dart';
import 'infoScreen.dart';
import 'searchScreen.dart';
import 'profileScreen.dart';
import 'confirmationScreen.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'myHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(title: 'Pagina inicial'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SearchScreen(
              workers: [],
            ),
        '/profile': (context) => ProfileScreen(worker: null),
        '/confirmation': (context) => ConfirmationScreen(),
        '/info': (context) => InfoScreen(),
      },
    );
  }
}
