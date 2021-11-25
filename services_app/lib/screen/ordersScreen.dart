import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:services_app/models/order.dart';
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

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  DateTime? date;
  String? dropdownValue;
  String? dateText;
  int userId = 1;

  List<Widget> itemsData = [];

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

  void cancelOrder(BuildContext context, int orderId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        Text("Deseja Cancelar?"),
        ListTile(
          title: Text('Sim'),
          onTap: () {
            Navigator.pop(context);
            WorkersDatabase.instance.deleteOrder(orderId);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Não'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }

  //final StreamController ctrl = StreamController();
  //final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));

  //ctrl.sink.add(WorkersDatabase.instance.readAllTurns());

  @override
  Widget build(BuildContext context) {
    final Future<List<Order>> listOrders =
        WorkersDatabase.instance.readAllOrders(userId);

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
          children: [SizedBox(height: 40), _buildListOrders(listOrders)],
        ),
      ),
    );
  }

  Widget buildOrderCard(
      BuildContext context, int index, List<Order> listOrders) {
    final order = listOrders[index];
    final img = "assets/2318271-icone-do-perfil-do-usuario-grátis-vetor.jpg";
    Future<Worker> worker = WorkersDatabase.instance.readWorker(order.workerId);
    return new GestureDetector(
        onTap: () async {
          cancelOrder(context, order.id);
        },
        child: Container(
          height: 170,
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: defaultTheme.shadowColor, blurRadius: 2.0),
              ]),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
              child: FutureBuilder<Worker>(
                  future: worker,
                  builder:
                      (BuildContext context, AsyncSnapshot<Worker> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  order.address.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  order.date.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "\$${order.price!.toStringAsFixed(2)}",
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
                  })),
        ));
  }

  Widget _buildListOrders(Future<List<Order>> listOrders) {
    List<Order>? newList;

    return FutureBuilder<List<Order>>(
        future: listOrders,
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
                  height: 600,
                  child: new ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildOrderCard(context, index, snapshot.data!)))
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
