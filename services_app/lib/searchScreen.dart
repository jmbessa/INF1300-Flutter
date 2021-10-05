import 'package:flutter/material.dart';
import 'package:services_app/workers.dart';
import 'package:intl/intl.dart';
import 'themes.dart';
import 'workers.dart';

class SearchScreen extends StatefulWidget {
  final List<Worker> workers;

  SearchScreen({Key? key, required this.workers}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? date;
  String? dropdownValue;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  String getText() {
    if (date == null) {
      return "Escolha a data";
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, List<Worker>>;
    final listWorkers = routeData['workers'];
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
            "Agendar",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
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
            ),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Turno", style: defaultTheme.textTheme.bodyText1)),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: dropdownValue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5)))),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                hint: Container(
                  child: Text(
                    "Escolha o turno",
                    textAlign: TextAlign.start,
                  ),
                ),
                items: <String>['Manhã', 'Tarde', 'Noite']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(
                        value,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Container(
                  child: new ListView.builder(
                      itemCount: listWorkers!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildWorkerCard(context, index, listWorkers))),
            )),
          ],
        ),
      ),
    );
  }

  Widget buildWorkerCard(
      BuildContext context, int index, List<Worker> listWorkers) {
    final work = listWorkers[index];
    final img = "assets/2318271-icone-do-perfil-do-usuario-grátis-vetor.jpg";
    return new Container(
        height: 145,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5.0),
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
                    "\$${work.price.toStringAsFixed(2)}",
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

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
