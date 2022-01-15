import 'dart:convert';
import 'dart:io';
import 'package:manga_cat/resources/Constants.dart';
import 'package:http/http.dart' as http;


// Class - FollowAPI
// Functions:
// follow - Takes in a log in token and a manga ID and uses a post request to follow the manga on the given account.
// unfollow - Functions much like follow but unfollows a manga.
class FollowAPI {
  static Future<String> follow(token, mangaID) async {
    var path  = 'manga/' + mangaID + '/follow';
    var response  = await http.post(Uri.https(Constants.mangadexAPI, path),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var decode = jsonDecode(response.body);
    print(decode);
    var data = decode["result"];

    if(response.statusCode == 200 || response.statusCode == 400) {
      return data;
    }
    else {
      throw Exception("Failed to load data");
    }
  }

  static Future<String> unfollow(token, mangaID) async {
    var path  = 'manga/' + mangaID + '/follow';
    var response  = await http.delete(Uri.https(Constants.mangadexAPI, path),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var decode = jsonDecode(response.body);
    print(decode);
    var data = decode["result"];

    if(response.statusCode == 200 || response.statusCode == 400) {
      return data;
    }
    else {
      throw Exception("Failed to load data");
    }
  }
}