import 'dart:convert';

import 'package:billing_web/models/login_request.dart';
import 'package:billing_web/models/login_response.dart';
import 'package:billing_web/resources/api_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var response =
        await ApiBaseHelper().postMethod("/signin/", json.encode(loginRequest));

    LoginResponse loginResponse =
        LoginResponse.fromJson(json.decode(response.body));

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("token", loginResponse.token);

    return loginResponse;
  }
}
