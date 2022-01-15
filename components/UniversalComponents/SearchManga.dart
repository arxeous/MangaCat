import 'package:flutter/material.dart';
import 'package:manga_cat/screens/ResultsScreen.dart';
import 'package:manga_cat/screens/TitleScreen.dart';

import '../Classes/Manga.dart';
import '../API/MangaAPI.dart';

// Class - MangaSearch
// Functionality - This class serves to display all the stuff that appears on the screen when searching for a manga, like suggestions, what to do when you press a suggestion, and what to do when you press search
//                  after you type something in. Build action allows you to clear our any query input, while build leading is what lets you go back from the query.
//                  buildSuggestions obviously displays the search suggestions while buildResults takes you to a screen where you can see all the suggestions in their mangacard format.


class MangaSearch extends SearchDelegate<String> {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () { return
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return ResultsScreen(MangaAPI.getMangaData(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder<List<Manga>>(
        future: MangaAPI.getMangaData(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("No connection");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text("Loading");
            case ConnectionState.done:
              if(snapshot.hasData)
                return MangaSuggestions(snapshot.data);
              return Text("No Result");
          }
        }
    );


  }

  Widget MangaSuggestions(List<Manga> manga) {
    return ListView.builder(
      itemCount: manga.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(manga[index].name),
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => TitleScreen(manga[index]),
              ),
            );
          }
        );
        },
    );

  }


}