import 'dart:convert';

import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    print("masuk");
    var body = {"email": email, "password": password};
    print("masuk2");
    var response = await Api().post(apiUrl, body);
    print("masuk3");
    var jsonObj = json.decode(response.body);
    print("masuk4");
    return Login.fromJson(jsonObj);
  }
}
