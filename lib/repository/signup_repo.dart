import 'dart:convert';
import 'dart:developer';

import '../models/createUser_request.dart';
import '../models/login_response.dart';
import '../models/userDetail.dart';
import '../resources/api_base_helper.dart';


class SignupRepository {
  Future<LoginResponse> login(CreateuserRequest loginRequest) async {
    var response =
        await ApiBaseHelper().postMethod("/signup/", json.encode(loginRequest));
    log(loginRequest.Branch.toString());
    LoginResponse signupResponse =
        LoginResponse.fromJson(json.decode(response.body));

    return signupResponse;
  }

  Future<List<UserDetail>> fetchUsers() async {
    var response = await ApiBaseHelper().getMethod("/allusers/");

    List<UserDetail> userResponse = List.from(
        json.decode(response.body).map((e) => UserDetail.fromJson(e)));

    return userResponse;
  }

  Future<dynamic> updateUser(int id, CreateuserRequest loginRequest) async {
    var response = await ApiBaseHelper()
        .putMethod("/user/${id}", json.encode(loginRequest));

    return response;
  }

  Future<dynamic> deleteUser(int id) async {
    var response = await ApiBaseHelper().deleteMethod("/user/${id}");

    return response;
  }
}
