import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manga_cat/components/API/FollowAPI.dart';
import 'package:manga_cat/components/UniversalComponents/PopUp.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:manga_cat/screens/ChapterScreen.dart';
import 'package:manga_cat/screens/TitleScreen.dart';

// Class - DetailsButton
// Functionality - This class displays the button portion in our title screen. Technically there are only two clickable buttons, the one for following a manga and the one for reading the first chapter of the manga.
//                  The other "Button" really just displays the total number of chapters a manga has. This class is stateful due to the fact that there was some testing of certain functionality that required a stateful
//                  widget, but was eventually scrapped for a simpler app behavior. Honestly I did't want to change it back to stateless again, just in case I decide to try and implement the functionality in the future.



class DetailsButton extends StatefulWidget {
  final MangaTitleDetails manga;
  const DetailsButton(this.manga);

  @override
  _DetailsButtonState createState() => _DetailsButtonState();
}

class _DetailsButtonState extends State<DetailsButton> {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var firstVol = widget.manga.mangaVolumes.length - 1;
    var firstChap = !(firstVol < 1) ? widget.manga.mangaVolumes[firstVol].chapterList.length - 1: 0;
    var chapter = !(firstChap < 1) ? widget.manga.mangaVolumes[firstVol].chapterList[firstChap].chapterID : "none";
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left:14),
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: () async {
                final token = await storage.read(key: "token");
                final followed = await storage.read(key: widget.manga.mangaName);
                if(token == null ) {
                  PopUp.createAlert(context, "Not Currently Logged In");
                }
                else if(followed != null){
                  storage.delete(key: widget.manga.mangaName);
                  FollowAPI.unfollow(token, widget.manga.mangaID);
                  PopUp.createAlert(context, "Unfollowed Manga");
                }
                else {
                  storage.write(key: widget.manga.mangaName, value: "followed");
                  FollowAPI.follow(token, widget.manga.mangaID);
                  PopUp.createAlert(context, "Followed Manga");
                }
              },
              icon: Icon(Icons.bookmark_add),
              color: Constants.mangaOrange,
              iconSize: 50,
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:10),
            height: 40,
            width: 80,
            alignment: Alignment.center,

            child: Text(widget.manga.mangaChapterTotal + " ch",
              overflow: TextOverflow.ellipsis,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Constants.titleCardGray,
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(left: 20),
            child: TextButton(
                onPressed: () {
                  if (widget.manga.mangaVolumes.length == 0) {
                    PopUp.createAlert(context, "No Chapters");
                  }
                  else {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => ChapterScreen(chapter),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.chrome_reader_mode),
                    Container(
                        child: Text("Read", style: TextStyle(fontSize: 15),)
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                  primary: Constants.textBlack,
                  backgroundColor: Constants.titleCardGray,
                  alignment: Alignment.center,
                )
            ),
          ),
        ],
      ),
    );
  }
}

