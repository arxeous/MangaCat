import 'package:flutter/material.dart';
import 'package:manga_cat/components/Classes/Manga.dart';
import 'MangaCard.dart';

// Class - ListComponent
// Functionality - This class displays a list of manga in the neat form that can be seen in the home screen of the app. Notice that we have a ternary operator which checks if the variable mangas is null or not.
//                  This is because this class allows us to take in either a future list of manga or an actual instance of the list. This saves some hassle in having to write a seperate class for each class
//                  when either variable is required to be passed. For the most part the code is the same, using a single child scroll view and bouncing scroll physics to display all the manga,
//                  one just has to wait for its information before loading the page while the other has it instantly.

class ListComponent extends StatelessWidget {
  late Future<List<Manga>> mangaFuture;
  List<Manga>? mangas = null;
  String displayText = "";
  ListComponent(this.mangaFuture, this.displayText);
  ListComponent.NormalList(this.mangas, this.displayText);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return mangas == null
        ? Container(
            height: screenSize.height,
            width: double.infinity,
            child: FutureBuilder<List<Manga>>(
              future: mangaFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("No connection");
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Text("Loading");
                  case ConnectionState.done:
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 5,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 30,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              displayText,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          if (snapshot.hasData)
                            for (int i = 0; i < snapshot.data.length; i++)
                              MangaCard(snapshot.data[i])
                        ],
                      ),
                    );
                  default:
                    return Text("done");
                }
              },
            ))
        : Container(
            height: screenSize.height,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Wrap(
                runSpacing: 10,
                spacing: 5,
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      displayText,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  for (int i = 0; i < mangas!.length; i++)
                      MangaCard(mangas![i])
                ],
              ),
            ));
  }
}
