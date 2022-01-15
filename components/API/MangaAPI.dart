import 'dart:convert';
import 'package:manga_cat/resources/Constants.dart';
import '../Classes/Manga.dart';
import 'package:http/http.dart' as http;

// Class - LogoutAPI
// Functions:
// getMangaData - This code is almost exactly like the followlistAPI code, except here we are handling a future, rather than a concrete instance
//                of Manga List. From there we handle the data like usual.
// getMangaCover - same reasoning as explained above.


class MangaAPI {
  static Future<List<Manga>> getMangaData(query) async {
    var title = { "title" : query};
    List<Manga> mangas = [];
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, Constants.mangadexList, title ));
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
