import 'dart:convert';
import 'dart:io';
import 'package:manga_cat/resources/Constants.dart';
import '../Classes/Manga.dart';
import 'package:http/http.dart' as http;


// Class - FollowListAPI
// Functions:
// getMangaData - Very similar to the api calls in the main chapter list screen, except its been abstracted into its own class for use in
//                displaying a users current follow list
// getMangaCover - Since the API stores the link to the cover of the manga somewhere else, we require another function to go retrieve it.
//                By using Future.wait when we call the function we asure that the function does not return until it collects the data necessary to display the card properly

class FollowListAPI {
  static Future<List<Manga>> getMangaData(token) async {
    var path = "user/follows/" + Constants.mangadexList;
    List<Manga> mangas = [];
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, path,),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var jsonData = jsonDecode(response.body);

    for (var u in jsonData["data"]) {
      var name = u["attributes"]["title"]["en"];
      var descrip = u["attributes"]["description"]["en"];
      var ID = u["id"];
      String coverID = "";
      String authorID = "";

      for (var i in u["relationships"]) {
        if (i["type"] == "cover_art") {
          coverID = i["id"];
        }
        if (i["type"] == "author") {
          authorID = i["id"];
        }
      }
      Manga manga = Manga(name, coverID, ID, descrip, authorID);
      mangas.add(manga);
    }
    await Future.wait(
        mangas.map((item) async {
          item.mangaCoverURL = await getMangaCover(item);
        }
        )
    );

    return mangas;
  }

  static Future<String> getMangaCover(Manga aManga) async {
    var path = Constants.mangadexCover + "/" + aManga.coverID;
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, path));
    var jsonData = jsonDecode(response.body);
    var string = Constants.uploadCover + '/' + aManga.mangaID + '/' +
        jsonData["data"]["attributes"]["fileName"];
    aManga.mangaCoverURL = string;
    return string;
  }
}
