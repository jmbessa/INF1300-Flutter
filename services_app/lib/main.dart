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
    //WorkersDatabase.instance.create(Worker(1,"Pedro Cunha", "Categorias.limpeza", 120.00, 4.0,
    //  "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));
    //WorkersDatabase.instance.create(Worker(2,"Pedro Cunha", "Categorias.limpeza", 120.00, 4.0,
    //  "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));

    //WorkersDatabase.instance.create(Worker(3,"Pedro Cunha", "Categorias.limpeza", 120.00, 4.0,
    //  "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));
    //WorkersDatabase.instance.create(Worker(4,"Carlinhos", "Pintura", 120.00, 4.0,
    //  "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Pagina inicial'),
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
