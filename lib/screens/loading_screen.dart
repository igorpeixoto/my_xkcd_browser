import 'package:flutter/material.dart';
import 'package:xkcd_browser/services/xkcd.dart';
import 'package:xkcd_browser/screens/browser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // variables
  int currentScale = 1; // stores the current scale
  int previousScale; // stores the last scale

  @override
  // initState
  void initState() {
    super.initState();

    // Get XKCD
    getXKCD();
  }

  void getXKCD() async {
    // Create xkcd object
    Xkcd xkcd = Xkcd();

    // Call api and store decoded data
    var xkcdData = await xkcd.getXkcdData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Browser(
        xkcdData: xkcdData,
      );
    }));

//    xkcdLatestNumber = xkcdLatestNumber ??
//        xkcdData['num']; // only updates latest number if it's null
//    xkcdImgURL = xkcdData['img']; // image URL
//    xkcdTitle = xkcdData['title']; // title
//    xkcdAltText = xkcdData['alt']; // alternate text
//    xkcdCurrentNumber = xkcdCurrentNumber ??
//        xkcdLatestNumber; // if xkcdNumber is null use latest number

//    //print(xkcd.imgURL);
//    print(xkcd.title);
//    print(xkcd.latest);
//    print(xkcd.xkcdNumber);
//    print(xkcd.altText);
//
//    imgURL = xkcd.imgURL;

//    title = xkcd.getTitle();
//    altText = xkcd.getAltText();
  }
//
//  void updateXKCD() {
//    imgURL = xkcd.getImgURL();
//    title = xkcd.getTitle();
//    altText = xkcd.getAltText();
//    xkcdNumber = xkcd.getXkcdNumber();
//    latest = xkcd.getLatest();
//  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('images/logo.png'),
            SpinKitRing(
              color: Colors.black,
              duration: Duration(
                milliseconds: 1550,
              ),
            )
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
