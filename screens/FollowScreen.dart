import 'package:flutter/material.dart';
import 'package:manga_cat/components/Classes/Manga.dart';
import 'package:manga_cat/components/UniversalComponents/ListComponent.dart';
import 'package:manga_cat/components/UniversalComponents/MainAppBar.dart';
import 'package:manga_cat/components/UniversalComponents/SideMenu.dart';

// Class - FollowScreen
// Functionality - This class displays all the manga that a logged in user of mangadex is following. All it does is call our mangalist class to display the followed manga if we any
//                  and text that says 'No follows' if we dont. Most screens follow the same pattern of being a scaffold with the typical mainappbar component and sidemenu component to round it out.
//


class FollowScreen extends StatefulWidget {
  final List<Manga> myManga;
  const FollowScreen(this.myManga);

  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MainAppBar(),
        drawer: SideMenu(),
        body: //ListComponent(mangaFuture),
        Container(
          child: widget.myManga != null ? ListComponent.NormalList(widget.myManga, "Current Follows") : Text("No follows"),
          //ElevatedButton(child:Text("button"), onPressed: () {getMangaData();},),
        )
    );
  }
}
