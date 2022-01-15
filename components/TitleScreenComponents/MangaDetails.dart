import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_cat/components/UniversalComponents/CustomCache.dart';
import 'package:manga_cat/screens/TitleScreen.dart';

// Class - MangaDetails
// Functionality - This class displays the manga cover along with the manga name and author to the side of the cover in our title screen. Like most of the classes
//                  in the title screen components folder, this information is coming from the MangaTitleDetails class. We do use a cachednetworkimage to display our cover
//                  mainly due to the fact that it caches the image for the allotted amount of time we give it in our custom cache manager.




class MangaDetails extends StatelessWidget {
  final MangaTitleDetails manga;
  const MangaDetails(this.manga);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 190,
            width: 120,
            child: CachedNetworkImage(
              cacheManager: CustomCache.customCahce(),
              imageUrl: manga.mangaCoverURL,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 170,
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(manga.mangaName, style: TextStyle(fontSize: 30), overflow: TextOverflow.ellipsis,),
                Text(manga.mangaAuthor, style: TextStyle(fontSize: 20),textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,)
              ],
            )
          )

        ],
      ),
    );
  }
}