import 'dart:math';

import 'package:flutter/material.dart';
import 'package:services_app/l10n/l10n.dart';
import 'package:services_app/models/workers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/infoScreen.dart';
import 'screen/searchScreen.dart';
import 'screen/profileScreen.dart';
import 'screen/confirmationScreen.dart';
import 'screen/loginScreen.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'database/database_connection.dart';
import 'screen/myHome.dart';
import 'models/workers.dart';
import 'models/user.dart';
import 'models/turn.dart';
import 'models/category.dart';
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
          // WorkersDatabase.instance.createUser(User(
          //     "carlinhos",
          //     "carlinhos123",
          //     "Carlos",
          //     "assets/casaLimpa1.jpg",
          //     "assets/casaLimpa1.jpg",
          //     "Av do lado daquela"));
          // WorkersDatabase.instance.create(Worker(
          //     1,
          //     "Pedro Cunha",
          //     120.00,
          //     "Manha,Tarde",
          //     "Sou uma pessoa muito organizada, que irá cuidar bem da sua casa.",
          //     4.0,
          //     "Limpeza",
          //     "assets/casaLimpa1.jpg;assets/casaLimpa2.jpg",
          //     "25/11/2021;26/11/2021;27/11/2021;28/11/2021;29/11/2021;30/11/2021"));
          // WorkersDatabase.instance.create(Worker(
          //     2,
          //     "Júlia Dias",
          //     350.00,
          //     "Manha,Tarde,Noite",
          //     "Sou uma pessoa muito organizada, muito feliz, que irá cuidar bem da sua casa.",
          //     4.6,
          //     "Limpeza",
          //     "assets/casaLimpa3.jpg;assets/casaLimpa2.jpg",
          //     "25/11/2021;28/11/2021;29/11/2021;30/11/2021"));

          // WorkersDatabase.instance.create(Worker(
          //     3,
          //     "Livia Ferreira",
          //     290.00,
          //     "Tarde,Noite",
          //     "Sou uma pessoa muito organizada, muito feliz, que irá  pindar cuidar bem sua casa.",
          //     4.6,
          //     "Pintura",
          //     "assets/casaLimpa1.jpg;assets/casaLimpa4.jpg",
          //     "25/11/2021;26/11/2021;27/11/2021;28/11/2021"));

          // WorkersDatabase.instance.createTurn(Turn(1, "Manha"));
          // WorkersDatabase.instance.createTurn(Turn(2, "Tarde"));
          // WorkersDatabase.instance.createTurn(Turn(3, "Noite"));

          // WorkersDatabase.instance.createCategory(
          //     CategoryObj(1, "Pintura", "assets/materiais-para-pintura.jpg"));
          // WorkersDatabase.instance
          //     .createCategory(CategoryObj(2, "Limpeza", "assets/limpeza.jpg"));
          // WorkersDatabase.instance.createCategory(CategoryObj(
          //     3, "Mecanica", "assets/b58b8561-dia-do-mecanico.jpg"));
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
              '/login': (BuildContext context) => new LoginPage(),
              '/': (BuildContext context) => new LoginPage(),
              '/second': (context) => SearchScreen(
                    category: "",
                  ),
              '/profile': (context) => ProfileScreen(worker: null),
              '/confirmation': (context) => ConfirmationScreen(),
              '/info': (context) => InfoScreen(),
            },
          );
        },
      );
}
