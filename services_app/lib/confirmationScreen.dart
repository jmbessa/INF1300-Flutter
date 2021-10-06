import 'package:flutter/material.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'package:photo_view/photo_view.dart';

class ConfirmationScreen extends StatefulWidget {
  ConfirmationScreen({Key? key}) : super(key: key);
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  late String _address;
  late String _date;
  late String turn;
  late String? _hour;
  late String _estimatedTime;
  late String _price;
  late String _observation;
  //String _phoneNumber;

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      maxLength: 40,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
      onSaved: (value) {
        _address = value!;
      },
    );
  }

  Widget _buildDate() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Preco",
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(1, 0, 0, 9),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                "4.8",
                style: const TextStyle(fontSize: 17, color: Colors.black),
              ),
              Icon(
                Icons.star,
                size: 14,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    ]);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                _buildAddress(),
                _buildDate(),
                SizedBox(height: 100),
                FloatingActionButton.extended(
                    label: Text(
                      'Submit',
                      style: buttonTheme.textTheme.bodyText1,
                    ),
                    backgroundColor: buttonTheme.primaryColor,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    })
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
