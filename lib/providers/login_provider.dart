import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider {

  final String _url = "http://www.invitacionaboda.com/WebService/v1";

  Future<Map<String, dynamic>> loginValidate( String username, String password ) async {

    final url = '$_url/login.php?username=$username&password=$password';
    var response = await http.get( Uri.parse(url) );

    final Map<String, dynamic> dataLogin = json.decode(response.body);

    return dataLogin;

  }  

}