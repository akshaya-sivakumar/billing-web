import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';

class ApiBaseHelper {
  Future<http.Response> postMethod(String url, String request) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token") ?? "";
    var headers = await createHeaders();
    var response = await http.post(Uri.parse(AppConstants.base_url + url),
        headers: headers, body: request);

    handleResponse(response);
    return response;
  }

  Future<Map<String, String>> createHeaders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token") ?? "";
    return {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Expose-Headers": "Content-Length, X-JSON",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",

      "token": token
    };
  }

  //

  void handleResponse(http.Response response) {
    if (response.statusCode != 200) {
      logError(response.request.toString(), response.body);
      throw "${json.decode(response.body)["message"]}";
    } else {
      logSuccess(response.request.toString(), response.body);
    }
  }

  Future<http.Response> getMethod(String url) async {
    var headers = await createHeaders();
    var response = await http.get(Uri.parse(AppConstants.base_url + url),
        headers: headers);
    handleResponse(response);
    return response;
  }

  Future<http.Response> deleteMethod(String url) async {
    var headers = await createHeaders();
    var response = await http.delete(Uri.parse(AppConstants.base_url + url),
        headers: headers);
    handleResponse(response);
    return response;
  }

  Future<http.Response> putMethod(String url, String request) async {
    var headers = await createHeaders();
    var response = await http.put(Uri.parse(AppConstants.base_url + url),
        headers: headers, body: request);

    handleResponse(response);
    return response;
  }

  void logSuccess(String logName, dynamic msg) {
    log('\x1B[32m$logName $msg\x1B[0m');
  }

  void logError(String logName, dynamic msg) {
    log('\x1B[31m$logName $msg\x1B[0m');
  }
}
