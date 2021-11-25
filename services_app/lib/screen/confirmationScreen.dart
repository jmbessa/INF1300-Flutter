import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes.dart';
import '../models/workers.dart';
import '../models/profile.dart';
import '../widgets/sideMenu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../database/database_connection.dart';
import 'loginScreen.dart';

class ConfirmationScreen extends StatefulWidget {
  final Worker? worker;

  ConfirmationScreen({Key? key, this.worker}) : super(key: key);
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  DateTime? _date;
  late String _turn;
  late String? _hour;
  late String _estimatedTime;
  late String _price;
  late String observation;
  late String? dateText;
  late String confirmationAddress;
  String? globalDropdownValue;
  final formKey = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
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

    setState(() => _date = newDate);
  }

  String getText() {
    if (_date == null) {
      setState(() {
        dateText = null;
      });
      return AppLocalizations.of(context)!.escolhaData;
    } else {
      setState(() {
        dateText = '${_date!.day}/${_date!.month}/${_date!.year}';
      });
      return '${_date!.day}/${_date!.month}/${_date!.year}';
    }
  }

  Widget _buildAddress() {
    Future<String> _address = WorkersDatabase.instance.readAdress(1);
    return FutureBuilder(
        future: _address,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  initialValue:
                      snapshot.data != null ? snapshot.data.toString() : '',
                  maxLength: 40,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address is Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      confirmationAddress = value!;
                    });
                  },
                ),
              )
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

  Widget _buildObservation() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.observacao,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Form(
        key: formKey2,
        child: TextFormField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSaved: (value) {
            setState(() {
              observation = value!;
            });
          },
        ),
      )
    ]);
  }

  Widget _buildDate() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.data,
                  style: defaultTheme.textTheme.bodyText1)),
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
            AppLocalizations.of(context)!.preco,
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
                '\$${worker!.price!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildTurn(Worker? worker, String? dropdownValue) {
    String novaString;

    _turn = '';

    if (worker!.turn.length >= 2) {
      for (var i = 0; i < worker.turn.length; i++) {
        novaString = worker.turn[i].toString();
        _turn = _turn + novaString;
      }
    } else
      _turn = worker.turn.toString();

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.turno,
                style: defaultTheme.textTheme.bodyText1)),
      ),
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
            globalDropdownValue = newValue;
          },
          hint: Container(
            child: Text(
              AppLocalizations.of(context)!.escolhaTurno,
              textAlign: TextAlign.start,
            ),
          ),
          items: worker.turn
              .split(",")
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.start,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }

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
              AppLocalizations.of(context)!.confirmaAgendamento,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 10, 25, 0),
                    child: SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.insereEndereco,
                        style: defaultTheme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                  _buildAddress(),
                  _buildDate(),
                  _buildTurn(worker, globalDropdownValue),
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
              formKey.currentState!.save();
              formKey2.currentState!.save();
              WorkersDatabase.instance.createOrder(
                  1,
                  worker!.id!,
                  observation,
                  worker.price!,
                  confirmationAddress,
                  dateText!,
                  globalDropdownValue!);
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false);
  }
}
