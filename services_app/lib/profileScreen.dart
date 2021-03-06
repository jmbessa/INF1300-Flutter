import 'package:flutter/material.dart';
import 'package:services_app/notification_api.dart';
import 'models/workers.dart';
import 'themes.dart';
import 'widgets/sideMenu.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final Worker? worker;

  ProfileScreen({Key? key, this.worker}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> images = [
    "assets/materiais-para-pintura.jpg",
    "assets/limpeza.jpg",
    "assets/b58b8561-dia-do-mecanico.jpg",
    "assets/faz-tudo.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Worker>;
    var worker = routeData['worker'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: defaultTheme.backgroundColor,
        leading: BackButton(color: defaultTheme.backgroundColor),
        elevation: 0,
        title: Text(
          worker!.name,
          style: TextStyle(color: defaultTheme.backgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profilePicture.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 9),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$${worker.price!.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 9),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      worker.evaluation.toString(),
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.descricao,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras faucibus laoreet metus sed posuere. Etiam quis condimentum nunc, eu egestas ex. Mauris justo felis, iaculis ut lorem eget, mattis varius nulla. Mauris elementum imperdiet posuere. Nullam aliquam nulla orci, ut lobortis justo cursus ac. Aliquam mollis ultrices enim, tempus molestie nisl semper vel. Nunc nec libero arcu. Aliquam sem justo, bibendum at suscipit in, molestie eget nibh. Aenean vitae accumsan nibh, at consequat justo. Aenean lorem purus, fringilla lobortis vulputate venenatis, hendrerit commodo lacus. Duis at felis vitae elit imperdiet facilisis. ",
                    style: const TextStyle(fontSize: 17, color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.trabalhosAntigos,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 9),
              child: SizedBox(
                  height: 200,
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) => Row(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              )
                            ],
                          ))),
            ),
            SizedBox(height: 70)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: defaultTheme.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/confirmation',
              arguments: {'worker': worker});
        },
        label: Text(
          AppLocalizations.of(context)!.agendarBtn,
          style: buttonTheme.textTheme.bodyText1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
