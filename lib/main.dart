import 'package:flutter/material.dart';
import 'package:invitacionaboda_user/screens/screens.dart';
import 'package:invitacionaboda_user/shared_prefs/user_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final prefs = PreferenciasUsuario();
    var logeado = prefs.logeado;

    return MaterialApp(
      initialRoute: logeado == false ? '/login' : '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login'      : ( _ ) => const LoginScreen(),
        '/home'       : ( _ ) => const HomeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}