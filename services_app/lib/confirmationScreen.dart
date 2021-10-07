import 'package:flutter/material.dart';
import 'themes.dart';
import 'workers.dart';
import 'widgets/sideMenu.dart';

class ConfirmationScreen extends StatefulWidget {
  final Worker? worker;

  ConfirmationScreen({Key? key, this.worker}) : super(key: key);
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  DateTime? date;
  late String turn;
  late String? hour;
  late String estimatedTime;
  late String price;
  late String observation;
  //String _phoneNumber;

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

  String getText() {
    if (date == null) {
      return "Escolha a data";
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: address != null ? address.toString() : '',
          floatingLabelBehavior: FloatingLabelBehavior.never),
      maxLength: 40,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
      onSaved: (value) {
        address = value!;
      },
    );
  }

  Widget _buildObservation() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Observação",
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextField(
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      )
    ]);
  }

  Widget _buildDate() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Column(children: [
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
        ]));
  }

  Widget _buildPrice(Worker? worker) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Preço",
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                '\$${worker!.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildTurn(Worker? worker) {
    String novaString;
    Turnos? dropdownValue;
    turn = '';

    if (worker!.turn.length >= 2) {
      for (var i = 0; i < worker.turn.length; i++) {
        novaString = worker.turn[i].toString().split('.').last;
        turn = turn + novaString;
      }
    } else
      turn = worker.turn.toString().split('.').last;

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Turno", style: defaultTheme.textTheme.bodyText1)),
      ),
      SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField<Turnos>(
          isExpanded: true,
          value: dropdownValue,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(5)))),
          onChanged: (Turnos? newValue) {
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
          items: worker.turn.map<DropdownMenuItem<Turnos>>((Turnos value) {
            return DropdownMenuItem<Turnos>(
              value: value,
              child: Container(
                child: Text(
                  value.toString().split('.').last,
                  textAlign: TextAlign.start,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Worker>;
    var worker = routeData['worker'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          leading: BackButton(color: Colors.black),
          title: Text(
            "Confirmação de agendamento",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 10, 25, 0),
                  child: SizedBox(
                    child: Text(
                      "Insira seu endereço",
                      style: defaultTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                _buildAddress(),
                _buildDate(),
                _buildTurn(worker),
                _buildPrice(worker),
                _buildObservation(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Enviar',
            style: buttonTheme.textTheme.bodyText1,
          ),
          backgroundColor: buttonTheme.primaryColor,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
