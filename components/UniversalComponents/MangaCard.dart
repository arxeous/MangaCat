import 'package:flutter/material.dart';
import 'package:manga_cat/components/UniversalComponents/CustomCache.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:manga_cat/screens/TitleScreen.dart';
import '../Classes/Manga.dart';

// Class - MangaCard
// Functionality - This class displays squares with the manga cover you find when in the home screen/search screen/follow screen etc.
//                  Obviously when a user clicks on one of these cards they should be directed to the manga detail screen, which is why the gesture detector is there
//                  Other than that we simply format the data passed into us from the manga class and display it neatly for the user

class MangaCard extends StatelessWidget {
  final Manga manga;

  const MangaCard(this.manga);

  Widget build(BuildContext context) {


    return Container(
      height: 210,
      width: 120,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => TitleScreen(manga),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              flex: 90,
                child: Container(
                  child: CachedNetworkImage(
                    cacheManager: CustomCache.customCahce(),
                    imageUrl: manga.mangaCoverURL,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Constants.mangaOrange))),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    manga.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  color: Constants.titleCardGray,
                )
            ),
          ],
        ),
      )
    );
  }
}