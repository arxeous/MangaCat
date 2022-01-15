import 'package:flutter/widgets.dart';
// Class - Constants
// Functionality - This class serves to be our constants through our entire app for things like urls colors and json bodies for gets/post/deletes.
//                  It honestly helps having things all in one place since we don't have to bother with remembering certain stuff like colors.



class Constants {
  Constants._();

  static const String catImage = "https://mangaplanet.com/wp-content/uploads/2018/09/90B8EAA6-5BF9-42DE-A53D-28CB578D6280.png";
  static const Color mangaWhite = Color.fromARGB(255,255,255,255);
  static const Color textBlack = Color.fromARGB(255, 0,0,0);
  static const Color titleCardGray = Color.fromARGB(100, 199,199,199);
  static const Color mangaOrange = Color.fromARGB(255, 255,169,31);
  static const String mangadexAPI = "api.mangadex.org";
  static const String mangadexList = "manga";
  static const String mangadexCover = "cover";
  static const String uploadCover = "https://uploads.mangadex.org/covers/";
  static const String mangaAuthor = "author";
  static const String login = "api.mangadex.org/auth/login";
  static  const String mangaVolumes = "aggregate";
  static const queryParametersHomeScreen = {"limit" : "30", "availableTranslatedLanguage[]": "en", "hasAvailableChapters": "true"};
  static const queryParametersMangaChapters = {"translatedLanguage[]" : "en"};

}