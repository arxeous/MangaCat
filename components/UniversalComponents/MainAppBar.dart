import 'package:flutter/material.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'SearchManga.dart';


// Class - MainAppBar
// Functionality - This class displays appbar at the top of all the screens through out the app. The actual app bar is comprised of smalled components that take care of the search functionality and the
//                  drawer menu to the left. The search function is embedded into the app bar itself, while the drawer is within the scaffold call. The image button here is a little experiment in fancier looking
//                  button presses. All it really does is takes us back to the home screen by popping all other explored screens of the queue.

class MainAppBar extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.mangaWhite,
      title: Material(
        color: Constants.mangaWhite,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child:Row(
            children: [
              Ink.image(
                image: NetworkImage(Constants.catImage),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 6),
              Text(
                'MangaCat',
                style: TextStyle(fontSize: 25, color: Constants.textBlack),
              ),
              SizedBox(height: 6,)
            ],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(Icons.menu),
        color: Colors.black,
        iconSize: 45,
    ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MangaSearch());
          },
          icon: const Icon(Icons.search),
          color: Colors.black,
          iconSize: 40,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}




