import 'package:flutter/material.dart';
import 'package:services_app/workers.dart';
import 'infoScreen.dart';
import 'searchScreen.dart';
import 'profileScreen.dart';
import 'confirmationScreen.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Corrente',
      style: optionStyle,
    ),
    Text(
      'Index 2: Agendado',
      style: optionStyle,
    ),
    Text(
      'Index 3: Options',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

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
          actions: <Widget>[Container()],
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: defaultTheme.backgroundColor,
          title: Text(
            "Categorias",
            style: TextStyle(color: defaultTheme.backgroundColor),
          ),
        ),
      ),
      body: GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          double distance = details.globalPosition.dx - initial;
          if (distance < -20) _scaffoldKey.currentState?.openEndDrawer();
        },
        onPanEnd: (DragEndDetails details) {
          initial = 0;
        },
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(servicos.length, (index) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  Categorias categoriaAtual = Categorias.values[index];
                  List<Worker> workers = WORKERS
                      .where((element) => element.category == categoriaAtual)
                      .toList();
                  // Navigate to the second screen using a named route.
                  Navigator.pushNamed(context, '/second',
                      arguments: {'workers': workers});
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
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(children: [
                              Text(servicos[index],
                                  style: TextStyle(
                                      fontFamily: defaultTheme
                                          .textTheme.bodyText1!.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.transparent,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = Color.fromRGBO(0, 0, 0, 1))),
                              Text(
                                servicos[index],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ]))),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services_rounded),
            label: 'Corrente',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'Agendado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze_rounded),
            label: 'Options',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
