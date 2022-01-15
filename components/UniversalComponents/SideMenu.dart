import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manga_cat/components/API/FollowListAPI.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:manga_cat/screens/FollowScreen.dart';
import 'package:manga_cat/screens/LoginScreen.dart';
import '../API/LogoutAPI.dart';
import 'PopUp.dart';

// Class - SideMenu
// Functionality - This class displays the buttons within our drawer in our app bar. Buttons include login, logout and follows which displays all manga currently being followed.
//                  Obviously logging out and going to the follow screen require api calls, which is why you will find their respective classes within this class.
//                  Other than that most of the code here is just formatting of buttons to fit within the screen decently enough.

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    return Drawer(
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Ink.image(
                  image: NetworkImage(Constants.catImage),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Text(
                  'MangaCat',
                  style: TextStyle(fontSize: 25, color: Constants.textBlack),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 20, left: 20),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          size: 40,
                        ),
                        Container(
                            child: Text(
                          "   Login",
                          style: TextStyle(fontSize: 25),
                        )),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Constants.textBlack,
                      alignment: Alignment.center,
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 150,
                margin: EdgeInsets.only(top: 5, left: 80),
                child: TextButton(
                    onPressed: () async {
                      final token = await storage.read(key: "token");
                      if(token == null) {
                        PopUp.createAlert(context, "Not Currently Logged In");
                      }
                      else {
                        storage.delete(key: "token");
                        final result = await LogoutAPI.logout(token);
                        PopUp.createAlert(context, "Logged out");
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        Container(
                            child: Text(
                          " Logout",
                          style: TextStyle(fontSize: 15),
                        )),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Constants.textBlack,
                      alignment: Alignment.center,
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 5, left: 30),
                child: TextButton(
                    onPressed: () async {
                      final token = await storage.read(key: "token");
                      print(token);
                      if (token == null) {
                        PopUp.createAlert(context, "Not Currently Logged In");
                      } else {
                        final mangas = await FollowListAPI.getMangaData(token);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FollowScreen(mangas),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 40,
                        ),
                        Container(
                            child: Text(
                          " Follows",
                          style: TextStyle(fontSize: 25),
                        )),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Constants.textBlack,
                      alignment: Alignment.center,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
