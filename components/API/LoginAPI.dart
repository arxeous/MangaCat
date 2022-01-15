import 'dart:convert';
import 'package:manga_cat/components/Classes/Login.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:http/http.dart' as http;

// Class - LoginAPI
// Functions:
// login - LoginRequestModel is simply a container for our login request which carries pertinent information for our login call. This includes username and password.
//         The code for the login page and api is NOT mine. I used a tutorial off youtube to streamline the building of the page, since this functionality wasn't ever really planned when I started working
//         on the app.
class LoginAPI {
  Future<LoginResponseModel> login(LoginRequestModel model) async {
    var path  = 'auth/login';
    var response  = await http.post(Uri.https(Constants.mangadexAPI, path),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJSON()),
    );

    if(response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("Failed to load data");
    }
  }
}