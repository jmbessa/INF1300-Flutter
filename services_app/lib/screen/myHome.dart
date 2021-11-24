import 'package:flutter/material.dart';
import 'package:services_app/models/category.dart';
import 'package:services_app/models/workers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../themes.dart';
import '../models/workers.dart';
import '../widgets/sideMenu.dart';
import '../database/database_connection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.signOut);

  final VoidCallback signOut;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  double initial = 0;
  List<String> servicos = [
    "Pintura",
    "Limpeza doméstica",
    "Mecânica",
    "Serviços Residenciais"
  ];

  List<String> images = [
    "assets/materiais-para-pintura.jpg",
    "assets/limpeza.jpg",
    "assets/b58b8561-dia-do-mecanico.jpg",
    "assets/faz-tudo.jpg",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Test1"),
        content: new Text("Test2"),
      ),
    );
  }

  String showDescriptions(String description) {
    if (description == "Pintura")
      return AppLocalizations.of(context)!.pintura;
    else if (description == "Servicos Residenciais")
      return AppLocalizations.of(context)!.servicosResidenciais;
    else if (description == "Mecanica")
      return AppLocalizations.of(context)!.mecanica;
    else
      return AppLocalizations.of(context)!.limpeza;
  }

  Future _showNotificationWithSound() async {
    var adnroidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'notification_channel_id', 'Channel Name');

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: adnroidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'New Post',
        'How to Show Notification in Fllutter', platformChannelSpecifics,
        payload: 'Default_Sound');
  }
  
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  Widget buildNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services_rounded),
          label: AppLocalizations.of(context)!.corrente,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_rounded),
          label: AppLocalizations.of(context)!.agendado,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dehaze_rounded),
          label: AppLocalizations.of(context)!.options,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: _onItemTapped,
    );
  }

  @override
  initState() {
    super.initState();
    // initialise the plugin.
    // If you want default icon change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    getPref();
  }

  final Future<List<CategoryObj>> categories =
      WorkersDatabase.instance.readAllCategories();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: 250,
        child: SideMenu(),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          actions: <Widget>[
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(Icons.lock_open),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: defaultTheme.backgroundColor,
          title: Text(
            AppLocalizations.of(context)!.categorias,
            style: TextStyle(color: defaultTheme.backgroundColor),
          ),
        ),
        body: FutureBuilder<List<CategoryObj>>(
            future: categories,
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryObj>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  GestureDetector(
                      onPanStart: (DragStartDetails details) {
                        initial = details.globalPosition.dx;
                      },
                      onPanUpdate: (DragUpdateDetails details) {
                        double distance = details.globalPosition.dx - initial;
                        if (distance < -20)
                          _scaffoldKey.currentState?.openEndDrawer();
                      },
                      onPanEnd: (DragEndDetails details) {
                        initial = 0;
                      },
                      child: Container(
                        height: 400,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            String description = showDescriptions(snapshot.data!
                                .where((element) => element.id == index + 1)
                                .map((e) => e.description)
                                .first);
                            return GestureDetector(
                              onTap: () {
                                //Category categoriaAtual = Category.values[index];
                                //List<Worker> workers = WORKERS
                                //    .where((element) => element.category == categoriaAtual)
                                //    .toList();
                                Navigator.pushNamed(context, '/second',
                                    arguments: {
                                      'category': snapshot.data!
                                          .where((element) =>
                                              element.id == index + 1)
                                          .map((e) => e.description)
                                          .first
                                    });
                              },
                              child: FractionallySizedBox(
                                heightFactor: 0.9,
                                widthFactor: 0.9,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  color: Colors.yellow,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(snapshot.data!
                                              .where((element) =>
                                                  element.id == index + 1)
                                              .map((e) => e.imagePath)
                                              .first),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Stack(children: [
                                            Text(description,
                                                style: TextStyle(
                                                    fontFamily: defaultTheme
                                                        .textTheme
                                                        .bodyText1!
                                                        .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foreground: Paint()
                                                      ..style =
                                                          PaintingStyle.stroke
                                                      ..strokeWidth = 2
                                                      ..color = Color.fromRGBO(
                                                          0, 0, 0, 1))),
                                            Text(
                                              description,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]))),
                                ),
                              ),
                            );
                          }),
                        ),
                      ))
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }),
        bottomNavigationBar: buildNavigationBar());
  }
}
