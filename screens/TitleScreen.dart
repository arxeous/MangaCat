import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manga_cat/components/Classes/Manga.dart';
import 'package:manga_cat/components/UniversalComponents/MainAppBar.dart';
import 'package:manga_cat/components/UniversalComponents/SideMenu.dart';
import 'package:manga_cat/components/TitleScreenComponents/ChapterList.dart';
import 'package:manga_cat/components/TitleScreenComponents/DetailsButtons.dart';
import 'package:manga_cat/components/TitleScreenComponents/MangaDescription.dart';
import 'package:manga_cat/components/TitleScreenComponents/MangaDetails.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:http/http.dart' as http;


// Class - TitleScreen
// Functionality - This class displays the manga cover, name, and author along with its description, buttons for follow and reading the 1st chapter and the list of chapters the manga has.
//                 Most of this functionality is within its own components in the TitleScreenComponents folder if more information if required. Other than that the bulk of the code here does the API calls
//                to collect things like the number of volumes and chapters the manga has. Also we have some extra classes that hold this information called MangaTitleDetails.
//                 Again we need this because the manga class only holds general information about the manga. MangaTitleDetails holds specific details about certain chapters and author, which is more important
//                  for a screen that we get the details of a manga from. Classes are explained and seen below. Like with the homescreen class we keep the API calls in the screen class when we need to wait for info before
//                  building a screen.

class TitleScreen extends StatefulWidget {
  final Manga manga;
  TitleScreen(this.manga);

  @override
  _TitleScreenState createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late Future<MangaTitleDetails> futureDetails;

  @override
  void initState() {
    super.initState();
    futureDetails = _getDetails();
  }

  Future<MangaTitleDetails> _getDetails() async{
    return await getDetails(widget.manga);
  }

  Future<MangaTitleDetails> getDetails(Manga thisManga) async {
    int count = 0;
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, Constants.mangaAuthor + "/" + thisManga.authorID));
    var jsonData = jsonDecode(response.body);

    MangaTitleDetails temp = MangaTitleDetails(thisManga.mangaDescription, thisManga.mangaCoverURL, jsonData["data"]["attributes"]["name"], thisManga.name, thisManga.mangaID);

    temp.mangaVolumes = await getVolumes(thisManga);
    for(var i in temp.mangaVolumes) {
      count += i.chapterList.length;
    }

    temp.mangaChapterTotal = count.toString();

    return temp;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<List<Volume>> getVolumes(Manga thisManga) async {
    List<Volume> volumeList = [];
    List<Chapter> chapterList = [];
    String volumeNumber;
    Chapter newChapter;
    Volume newVolume;

    var path = Constants.mangadexList + "/" + thisManga.mangaID + "/" + Constants.mangaVolumes;
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, path, Constants.queryParametersMangaChapters));
    var jsonData = jsonDecode(response.body);
    var test = jsonData["volumes"];

    test.forEach((k,v) => {
      if(isNumeric(k) && k != "0") {
        volumeNumber = k,
        v["chapters"].forEach((key,val) =>  {
          if(isNumeric(key)) {
            newChapter = Chapter(key, val["id"]),
            chapterList.add(newChapter)
          }
        }),
        newVolume = Volume(List.from(chapterList), volumeNumber),
        volumeList.add(newVolume),
        chapterList.clear(),
      }
    });

    return volumeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: MainAppBar(),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder<MangaTitleDetails>(
                future: futureDetails,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("No connection");
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Text("Waiting or active");
                        case ConnectionState.done:
                          return Column(
                              children: [
                                MangaDetails(snapshot.data),
                                DetailsButton(snapshot.data),
                                MangaDescription(snapshot.data),
                                ChapterList(snapshot.data),
                              ]
                          );
                  }
                  },
              )
            ],
        ),
      )

      ),
    );
  }
}


// Class - TitleScreen
// Functionality - This class contains info not found in the manga class like volume numbers, chapter total, and chapterID for when a user clicks on a certain chapter they want to read.
//                information for the classes that hold the volumes and chapters are collected in separate API calls.
class MangaTitleDetails {
  final String mangaDescript, mangaCoverURL, mangaAuthor, mangaName, mangaID;
  List<Volume> mangaVolumes = [];
  String mangaChapterTotal = "";
  MangaTitleDetails(this.mangaDescript, this.mangaCoverURL, this.mangaAuthor, this.mangaName, this.mangaID);
}


// Class - Volume
// Functionality - Holds the specific volumes chapters, along with the number of the volume
class Volume {
  final List<Chapter> chapterList;
  final String volumeNumber;
  Volume(this.chapterList, this.volumeNumber);
}

// Class - Chapter
// Functionality - Holds the specific chapters number and its chapterID so we can collect the images for that chapter.
class Chapter {
  final String chapterNum, chapterID;
  Chapter(this.chapterNum, this.chapterID);
}