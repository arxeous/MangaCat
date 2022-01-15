import 'package:flutter/material.dart';
import 'package:manga_cat/resources/Constants.dart';


// Class - LoginProgress
// Functionality - As explained before in other login files this is another class pertaining to the login screen which I did not come up with.
//                 This class serves to display a progress indicator while we log in. When the call is made we display a progress circle and when the login either fails or goes through
//                  The circle clears off the screen and the user can continue using the app.

class LoginProgress extends StatelessWidget {

  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  LoginProgress({
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Constants.mangaOrange)
              )
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}