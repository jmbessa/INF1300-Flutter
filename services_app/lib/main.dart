import 'package:flutter/material.dart';
import 'package:services_app/workers.dart';
import 'infoScreen.dart';
import 'searchScreen.dart';
import 'profileScreen.dart';
import 'confirmationScreen.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'database/database_connection.dart';
import 'myHome.dart';
import 'workers.dart';
import 'turn.dart';
import 'category.dart';

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
      
    //WorkersDatabase.instance.createTurn(Turn(1,"Manha"));
    //WorkersDatabase.instance.createTurn(Turn(2,"Tarde"));
    //WorkersDatabase.instance.createTurn(Turn(3,"Noite"));

    //WorkersDatabase.instance.createCategory(Category(1, "Pintura", "assets/materiais-para-pintura.jpg"));
    //WorkersDatabase.instance.createCategory(Category(2, "Limpeza", "assets/limpeza.jpg"));
    //WorkersDatabase.instance.createCategory(Category(3, "Mecanica", "assets/b58b8561-dia-do-mecanico.jpg"));
    //WorkersDatabase.instance.createCategory(Category(4, "Servicos Residenciais", "assets/faz-tudo.jpg"));


    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Pagina inicial'),
        '/second': (context) => SearchScreen(
              category: "",
            ),
        '/profile': (context) => ProfileScreen(worker: null),
        '/confirmation': (context) => ConfirmationScreen(),
        '/info': (context) => InfoScreen(),
      },
    );
  }
}
