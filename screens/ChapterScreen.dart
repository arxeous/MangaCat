import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manga_cat/components/UniversalComponents/CustomCache.dart';
import 'package:manga_cat/components/UniversalComponents/MainAppBar.dart';
import 'package:manga_cat/components/UniversalComponents/SideMenu.dart';
import 'package:manga_cat/resources/Constants.dart';


// Class - ChapterScreen
// Functionality - This class displays all the pages that can be found within a certain chapter of our manga passed in through the string chID. API calls that are required to be displayed when a screen is initialized
//                are NOT abstracted into their own classes, mainly because I didn't experiment with it, and I don't want to break the app over some extra lines of code in the screen class when I don't have too much
//                time to bug fix along with other classes im taking this winter. For the most part we just collect the images in a list, display them using our cache image class, and use a list view so we can scroll through
//                the pages, nothing fancy. Advancing to the next chapter requires that we have back out from the page and go back to the manga screen to find the next chapter.


class ChapterScreen extends StatefulWidget {
  final String chID;
  const ChapterScreen(this.chID);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}


class _ChapterScreenState extends State<ChapterScreen> {
  late Future<List<String>> pageURLS;

  @override
  void initState() {
    super.initState();
    pageURLS = _getChapterDetails();
  }

  Future<List<String>> _getChapterDetails() async{
    return await getChapterDetails(widget.chID);
  }

  Future<List<String>> getChapterDetails(String chapterID) async {
    List<String> images = [];
    var path = "at-home/server/" + chapterID;
    var response = await http.get(
        Uri.https(Constants.mangadexAPI, path));
    var jsonData = jsonDecode(response.body);

    var baseURL = jsonData["baseUrl"];
    var chapterHash = jsonData["chapter"]["hash"];
    var fileNames = jsonData["chapter"]["data"];
    var slash = "/";


    for(var i in fileNames) {
      images.add(baseURL + slash + "data" + slash + chapterHash + slash + i);
    }

  return images;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: MainAppBar(),
      body: Container(
        child: FutureBuilder<List<String>>(
          future: pageURLS,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return Text("");
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Text("");
              case ConnectionState.done:
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        cacheManager: CustomCache.customCahce(),
                        imageUrl: snapshot.data[index],
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Constants.mangaOrange))),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    });
            }

          },
        ),
      )
    );
  }
}
