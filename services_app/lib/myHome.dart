import 'package:flutter/material.dart';
import 'package:services_app/workers.dart';
import 'themes.dart';
import 'workers.dart';
import 'widgets/sideMenu.dart';

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
          crossAxisCount: 2,
          children: List.generate(servicos.length, (index) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  Categorias categoriaAtual = Categorias.values[index];
                  List<Worker> workers = WORKERS
                      .where((element) => element.category == categoriaAtual)
                      .toList();
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
