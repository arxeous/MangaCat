import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manga_cat/components/Classes/Manga.dart';
import 'package:manga_cat/components/UniversalComponents/ListComponent.dart';
import 'package:manga_cat/components/UniversalComponents/MainAppBar.dart';
import 'package:manga_cat/components/UniversalComponents/SideMenu.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:http/http.dart' as http;


// Class - HomeScreen
// Functionality - This class displays all our recently updated manga, specifically for those with english translations from the mangadex server. The actual main widget is nothing more to our list manga component
//                  with the heavy work of getting the actual information from the website being done in the getMangaData/getMangaCover functions. Because we need this data before we display anything on our screen
//                  we use the future builder in the component class to make sure we get the info before anything is put on screen. This is where the future constructor of that class comes in handy, since here we send in a
//                  future list of manga rather than an instance of manga when retrieving the data from an api call.

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Manga>> mangaFuture;

  @override
  void initState() {
    super.initState();
    mangaFuture = _getManga();
  }
  
  Future<List<Manga>> _getManga() async {
    return await getMangaData();
  }

  Future<List<Manga>> getMangaData() async {
    List<Manga> mangas = [];
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, Constants.mangadexList, Constants.queryParametersHomeScreen));
    var jsonData = jsonDecode(response.body);

    for (var u in jsonData["data"]) {
      var name = u["attributes"]["title"]["en"];
      var descrip = u["attributes"]["description"]["en"];
      var ID = u["id"];
      String coverID = "";
      String authorID = "";

      for(var i in u["relationships"]) {
        if(i["type"] == "cover_art") {
          coverID = i["id"];
        }
        if(i["type"] == "author") {
          authorID = i["id"];
        }
      }
      Manga manga = Manga(name,coverID, ID,descrip, authorID);
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

  Future<String> getMangaCover(Manga aManga) async {
      var path = Constants.mangadexCover + "/" + aManga.coverID;
      var response = await http.get(
          Uri.https(Constants.mangadexAPI, path));
      var jsonData = jsonDecode(response.body);
      var string = Constants.uploadCover + '/' + aManga.mangaID + '/' +
          jsonData["data"]["attributes"]["fileName"];
      aManga.mangaCoverURL = string;
      return string;

    }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(),
      appBar: MainAppBar(),
      body: //ListComponent(mangaFuture),
      Container(
        child: ListComponent(mangaFuture, "Recently Uploaded"),
        //ElevatedButton(child:Text("button"), onPressed: () {getMangaData();},),
      )
    );
  }
}


