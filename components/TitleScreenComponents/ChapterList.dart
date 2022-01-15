import 'package:flutter/material.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:manga_cat/screens/ChapterScreen.dart';
import 'package:manga_cat/screens/TitleScreen.dart';

// Class - ChapterList
// Functionality - This class serves to display the list of chapter that a manga has in our Title Screen. Because our information on a chapter is kept nice and neatly within the MangaTitleDetails class
//                  we simply only need to collect the appropriate chapter IDS so we can make the API call for the actual pages of the chapter when a chapter is clicked.
//                  To display the list we just use a container to hold our stuff along with the listViewBuilder to get a scrollable, clickable list of chapter numbers.



class ChapterList extends StatelessWidget {
  final MangaTitleDetails manga;
  const ChapterList(this.manga);


  @override
  Widget build(BuildContext context) {
    List<Chapter> chapters = [];
    for(int i = 0; i < manga.mangaVolumes.length; i++) {
      var volume = manga.mangaVolumes[i];
      for(int j = 0; j  < volume.chapterList.length; j++) {
        chapters.add(volume.chapterList[j]);
      }
    }

    return Container(
      height: 180,
      width: 360,
      decoration: BoxDecoration(
        color: Constants.titleCardGray,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListView.builder(
        itemCount: chapters.length,
          itemBuilder: (context, index) {
          return ListTile(
              title: Text("Chapter " + chapters[index].chapterNum + ".",
              style: TextStyle(fontSize: 18),),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => ChapterScreen(chapters[index].chapterID),
                ),
              );
            },
          );
        }
        ),
    );
  }
}


