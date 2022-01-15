import 'dart:convert';
import 'dart:io';
import 'package:manga_cat/resources/Constants.dart';
import 'package:http/http.dart' as http;

// Class - LogoutAPI
// Functions:
// logout - Unlike login, this is a static function like most of my original classes that I wrote. The function simply logs the user with a given token out of their account.
//          Its honestly not too difficult given that the API for mangadex is pretty straightforward to use.

class LogoutAPI {
  static Future<String> logout(token) async {
    var path  = 'auth/logout';
    var response  = await http.post(Uri.https(Constants.mangadexAPI, path),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var decode = jsonDecode(response.body);
    var data = decode["result"];

    if(response.statusCode == 200 || response.statusCode == 400) {
      return data;
    }
    else {
      throw Exception("Failed to load data");
    }
  }
}