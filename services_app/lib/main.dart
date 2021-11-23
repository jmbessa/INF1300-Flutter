import 'dart:math';

import 'package:flutter/material.dart';
import 'package:services_app/l10n/l10n.dart';
import 'package:services_app/workers.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'provider/locale_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          // WorkersDatabase.instance.create(Worker(
          //     1,
          //     "Pedro Cunha",
          //     "Categorias.limpeza",
          //     120.00,
          //     4.0,
          //     "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));
          // WorkersDatabase.instance.create(Worker(
          //     2,
          //     "Pedro Cunha",
          //     "Categorias.limpeza",
          //     120.00,
          //     4.0,
          //     "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));

          // WorkersDatabase.instance.create(Worker(
          //     3,
          //     "Pedro Cunha",
          //     "Categorias.limpeza",
          //     120.00,
          //     4.0,
          //     "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));
          // WorkersDatabase.instance.create(Worker(4, "Carlinhos", "Pintura", 120.00,
          //     4.0, "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"));

          // WorkersDatabase.instance.createTurn(Turn(1, "Manha"));
          // WorkersDatabase.instance.createTurn(Turn(2, "Tarde"));
          // WorkersDatabase.instance.createTurn(Turn(3, "Noite"));

          // WorkersDatabase.instance.createCategory(
          //     CategoryObj(1, "Pintura", "assets/materiais-para-pintura.jpg"));
          // WorkersDatabase.instance
          //     .createCategory(CategoryObj(2, "Limpeza", "assets/limpeza.jpg"));
          // WorkersDatabase.instance.createCategory(
          //     CategoryObj(3, "Mecanica", "assets/b58b8561-dia-do-mecanico.jpg"));
          // WorkersDatabase.instance.createCategory(
          //     CategoryObj(4, "Servicos Residenciais", "assets/faz-tudo.jpg"));

          // print("aaaaaa");
          // WorkersDatabase.instance.uploadFile();
          // print("bbbbb");

          return MaterialApp(
            title: 'Flutter Demo',
            theme: defaultTheme,
            supportedLocales: L10n.all,
            locale: provider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialRoute: '/',
            routes: {
              '/': (context) => const MyHomePage(title: 'Pagina inicial'),
              '/second': (context) => SearchScreen(
                    category: "",
                  ),
              '/profile': (context) => ProfileScreen(worker: null),
              // '/confirmation': (context) => ConfirmationScreen(),
              '/info': (context) => InfoScreen(),
            },
          );
        },
      );
}
