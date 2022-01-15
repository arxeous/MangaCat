import 'package:flutter/material.dart';
import 'package:manga_cat/components/Classes/Manga.dart';
import 'package:manga_cat/components/UniversalComponents/ListComponent.dart';

// Class - ResultsScreen
// Functionality - This class displays the results from a search query from the app bar search. Obviously because we've abstracted the list functionality we can just send in the future list of manga to the
//                 class and it will display it neatly for us.

class ResultsScreen extends StatefulWidget {
  final Future<List<Manga>> myManga;
  const ResultsScreen(this.myManga);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body:
        Container(
          child: ListComponent(widget.myManga, "Search Results"),
        )
    );
  }
}
