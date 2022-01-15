// Class - Manga
// Functionality - This class serves to contain all the pertinent information given to us by our call to the API when looking for a manga
//                  This includes things like the coverID so we can retrieve the cover, mangaID so we can retrieve the actual chapters, the description and the authorID.
//                  The mangaCoverURL variable is filled out in our actual call in collecting manga data with the getMangaCover function covered in the API classes folder.

class Manga{
  final String name, coverID, mangaID, mangaDescription, authorID;
  String mangaCoverURL = "";
  Manga(this.name, this.coverID, this.mangaID, this.mangaDescription, this.authorID);
}