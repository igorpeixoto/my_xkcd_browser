import 'package:flutter/material.dart';
import 'package:xkcd_browser/components/my_button.dart';
import 'package:xkcd_browser/utilities/constants.dart';
import 'package:xkcd_browser/services/xkcd.dart';
import 'package:flukit/flukit.dart';
import 'dart:math';

class Browser extends StatefulWidget {
  // variables
  final xkcdData;

  // constructor
  Browser({this.xkcdData});

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  // variables
  String xkcdImgURL;
  String xkcdTitle;
  String xkcdAltText;
  int xkcdCurrentNumber;
  int xkcdLatestNumber;
  var xkcdData;

  @override
  void initState() {
    super.initState();

    // update local variable and UI
    xkcdData = widget.xkcdData;
    updateUI(xkcdData);
  }

  // Create xkcd object
  Xkcd xkcd = Xkcd();

  dynamic getXkcdData() async {
    // Call api and store decoded data
    var xkcdData = await xkcd.getXkcdData();
    return xkcdData;
  }

  void updateUI(dynamic xkcdData) {
    xkcdLatestNumber = xkcdLatestNumber ??
        xkcdData['num']; // only updates latest number if it's null
    xkcdImgURL = xkcdData['img']; // image URL
    xkcdTitle = xkcdData['title']; // title
    xkcdAltText = xkcdData['alt']; // alternate text
    xkcdCurrentNumber = xkcdCurrentNumber ??
        xkcdLatestNumber; // if xkcdNumber is null use latest number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My XKCD Browser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
//                    'text',
                    xkcdTitle,
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
//                    'text',
                    '(#$xkcdCurrentNumber)',
                    style: kComicNumberTextStyle,
                  )
                ],
              ),
            ),

//            // Image

            Expanded(
              flex: 2,
              child: ClipRect(
                clipBehavior: Clip.hardEdge,
                child: ScaleView(
                  child: Image.network(xkcdImgURL),
                ),
              ),
//              child: Image.asset('images/westerns.png'),
            ),

            SizedBox(
              height: 10.0,
            ),
            // Alt text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
//                'text',
                xkcdAltText,
                style: kAltTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            // Bottom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  height: 70.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyButton(
                        label: 'BACK',
                        icon: Icon(Icons.chevron_left),
                        flex: 1,
                        onPressed: () async {
                          if (xkcdCurrentNumber > 0) {
                            xkcdCurrentNumber--;
                            xkcd.setXkcdCurrentNumber(xkcdCurrentNumber);
                            xkcdData = await getXkcdData();
                          }
                          setState(
                            () {
                              updateUI(xkcdData);
                            },
                          );
                        },
                      ),
                      MyButton(
                        label: 'RAND',
                        icon: Icon(Icons.shuffle),
                        flex: 1,
                        onPressed: () async {
                          // Generates a random number between 1 and the last xkcd comic number
                          xkcdCurrentNumber =
                              Random().nextInt(xkcdLatestNumber) + 1;

                          xkcd.setXkcdCurrentNumber(xkcdCurrentNumber);
                          xkcdData = await getXkcdData();

                          setState(
                            () {
                              updateUI(xkcdData);
                            },
                          );
                        },
                      ),
                      MyButton(
                        label: 'NEXT',
                        icon: Icon(Icons.chevron_right),
                        flex: 1,
                        onPressed: () async {
                          if (xkcdCurrentNumber < xkcdLatestNumber) {
                            xkcdCurrentNumber++;
                            xkcd.setXkcdCurrentNumber(xkcdCurrentNumber);
                            xkcdData = await getXkcdData();
                          }
                          setState(
                            () {
                              updateUI(xkcdData);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
