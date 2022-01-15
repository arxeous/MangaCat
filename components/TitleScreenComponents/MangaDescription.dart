import 'package:flutter/material.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:manga_cat/screens/TitleScreen.dart';
import 'package:readmore/readmore.dart';


// Class - DetailsButton
// Functionality - This class displays manga description given to us from our MangaTitleDetailsClass in our title screen. We use a single child scroll view to be able to scroll through text in the case
//                  that the description is pretty long and then the readmoretext class to trim out lines when the text is too unruly to display all at once.


class MangaDescription extends StatelessWidget{
  final MangaTitleDetails manga;
  MangaDescription(this.manga);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Desc.",
              style: TextStyle(fontSize: 20,),
                textAlign: TextAlign.left,
              ),
              ReadMoreText(
                manga.mangaDescript,
              trimLines: 4,
              style: TextStyle(
                color: Constants.textBlack
              ),
              moreStyle:  TextStyle(
                  color: Constants.textBlack
              ),
              lessStyle: TextStyle(
                  color: Constants.textBlack
              ),
              textAlign: TextAlign.justify,
              trimCollapsedText: "Show More",
              trimExpandedText: "Show Less",
            ),
            ]
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Constants.titleCardGray,
        ),
    )
    );
  }
}
