import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:services_app/models/workers.dart';
import '../themes.dart';
import '../models/workers.dart';
import '../models/category.dart';
import '../models/turn.dart';
import '../database/database_connection.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
//part 'counter.store.g.dart';

//class CounterStore = _CounterStore with $CounterStore;

class _CounterStore with Store {
  @observable
  late int valueStatus;

  @computed
  int get value => valueStatus;

  @action
  void setStream(int c) {
    valueStatus = c;
  }
}

class SearchScreen extends StatefulWidget {
  final String category;

  SearchScreen({Key? key, required this.category}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? date;
  String? dropdownValue;
  String? dateText;
  List<String> turnos = ['Manhã', 'Tarde', 'Noite'];

  List<Widget> itemsData = [];
  final _counter = _CounterStore();

  String getText() {
    if (date == null) {
      setState(() {
        dateText = null;
      });
      return AppLocalizations.of(context)!.escolhaData;
    } else {
      setState(() {
        dateText = '${date!.day}/${date!.month}/${date!.year}';
      });
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  //final StreamController ctrl = StreamController();
  //final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));

  //ctrl.sink.add(WorkersDatabase.instance.readAllTurns());

  final Future<List<Turn>> listTurn = WorkersDatabase.instance.readAllTurns();

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var category = routeData['category'];

    Future<List<Worker>> listWorkers =
        WorkersDatabase.instance.readWorkerByCategory(category!);

    String? turno;

    if (dropdownValue == "Manhã")
      turno = "Manha";
    else if (dropdownValue == "Tarde")
      turno = "Tarde";
    else if (dropdownValue == "Noite") turno = "Noite";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          leading: BackButton(color: Colors.black),
          title: Text(
            AppLocalizations.of(context)!.agendamento,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDateField(),
            SizedBox(height: 10),
            _buildDropDownTurn(category),
            SizedBox(height: 40),
            _buildListWorkers(listWorkers, turno)
          ],
        ),
      ),
    );
  }

  Widget buildWorkerCard(
      BuildContext context, int index, List<Worker> listWorkers) {
    final work = listWorkers[index];
    final img = "assets/2318271-icone-do-perfil-do-usuario-grátis-vetor.jpg";
    return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/profile', arguments: {"worker": work});
        },
        child: Container(
          height: 145,
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: defaultTheme.shadowColor, blurRadius: 2.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      work.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          work.evaluation.toString(),
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "\$${work.price!.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Image.asset(
                  img,
                  height: 120,
                )
              ],
            ),
          ),
        ));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 4),
    );

    if (newDate == null) {
      setState(() {
        dateText = null;
      });
      return;
    }

    setState(() => date = newDate);
  }

  Widget _buildDropDownTurn(String category) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.turno,
                style: defaultTheme.textTheme.bodyText1)),
        FutureBuilder<List<Turn>>(
          future: listTurn,
          builder: (BuildContext context, AsyncSnapshot<List<Turn>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5)))),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      //listWorkers = Stream.fromFuture(WorkersDatabase.instance
                      //    .readWorkerByFilter(category, dropdownValue!));
                      // _counter.setStream(5);
                    },
                    hint: Container(
                      child: Text(
                        AppLocalizations.of(context)!.escolhaTurno,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    items: snapshot.data
                        ?.map((t) => DropdownMenuItem<String>(
                              child: Text(t.description),
                              value: t.description,
                            ))
                        .toList(),
                  ),
                ),
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
          },
        )
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text("Data", style: defaultTheme.textTheme.bodyText1)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => pickDate(context),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  side: BorderSide(width: 1)),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getText(),
                    style: defaultTheme.textTheme.bodyText2,
                    textAlign: TextAlign.start,
                  ))),
        )
      ],
    );
  }

  Widget _buildListWorkers(Future<List<Worker>> listWorkers, String? turno) {
    List<Worker>? newList;

    return FutureBuilder<List<Worker>>(
        future: listWorkers,
        builder: (BuildContext context, AsyncSnapshot<List<Worker>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (dropdownValue != null)
              newList = snapshot.data!
                  .where((element) => element.turn.contains(dropdownValue!))
                  .toList();
            else
              newList = snapshot.data!;
            if (dateText != null) {
              newList = newList!
                  .where((element) => element.dates!.contains(dateText!))
                  .toList();
            }
            children = <Widget>[
              Container(
                  height: 400,
                  child: new ListView.builder(
                      itemCount: newList!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildWorkerCard(context, index, newList!)))
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
        });
  }
}
