import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screen/myHome.dart';
import '../services/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:services_app/database/database_connection.dart';
import '../themes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  late BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  late String _username, _password;
  late Future<int> _id;

  late LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        var loginForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo_size.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      onSaved: (val) => _username = val!,
                      decoration: new InputDecoration(labelText: "Username"),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      onSaved: (val) => _password = val!,
                      decoration: new InputDecoration(labelText: "Password"),
                    ),
                  )
                ],
              ),
            ),
          ],
        );

        return new Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: defaultTheme.backgroundColor,
              elevation: 0,
            ),
            key: scaffoldKey,
            body: new Container(
              child: new Center(
                child: loginForm,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: defaultTheme.primaryColor,
              onPressed: _submit,
              label: Text(
                "Login",
                style: buttonTheme.textTheme.bodyText1,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false);
        break;
      case LoginStatus.signIn:
        _id = WorkersDatabase.instance.getUserId(_username);
        return MyHomePage(signOut);
    }
  }

  void savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.username, user.password);
      _loginStatus = LoginStatus.signIn;
    } else {
      _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
