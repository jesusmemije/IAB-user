import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invitacionaboda_user/providers/login_provider.dart';
import 'package:invitacionaboda_user/shared_prefs/user_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Instance the shared preferences
  final prefs = PreferenciasUsuario();

  //Global Keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Provider
  final loginProvider = LoginProvider();

  //Variables
  String _username = "";
  String _password = "";
  String _textBtnLogin = "LOGIN";
  bool _progressLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg-login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 5.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Iniciar sesión', 
                      style: TextStyle(
                        fontSize: 30, 
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 42),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: const EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            color: Colors.pink,
                          ),
                          hintText: 'Usuario',
                        ),
                        onSaved: (value) => _username = value.toString(),
                        initialValue: 'cjmc12@hotmail.com',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.pink,
                          ),
                          hintText: 'Contraseña',
                        ),
                        onSaved: (value) => _password = value.toString(),
                        initialValue: 'admin',
                      ),
                    ),

                    /*Spacer(),*/

                    InkWell(
                      onTap: _progressLogin ? null : validate,
                      child: Container(
                        height: 45,
                        margin: const EdgeInsets.only(top: 32),
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.pinkAccent,
                                Colors.pink,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            _textBtnLogin,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validate() async {
    FocusScope.of(context).unfocus();

    var form = formKey.currentState;
    form!.save();

    if (_username.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(msg: 'El usuario y la contraseña son requeridos');
    } else {

      setState(() {
        _progressLogin = true;
        _textBtnLogin = "VALIDANDO DATOS...";
      });

      Map response = await loginProvider.loginValidate(_username, _password);

      if (response['ok'] == true) {

        prefs.logeado  = true;
        Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));

      } else {
        Fluttertoast.showToast(msg: response['response']);
        setState(() {
          _progressLogin = false;
          _textBtnLogin = "LOGIN";
        });
      }
    }
  }
  
}
