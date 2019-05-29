import 'package:http/http.dart' as http;
import 'dart:convert';

class Xkcd {
  // attributes
  int xkcdLatestNumber;
  String xkcdImgURL;
  String xkcdTitle;
  String xkcdAltText;
  String xkcdApiURL = 'https://xkcd.com/info.0.json';
  int xkcdCurrentNumber;

  // Getters and Setters

  void setXkcdCurrentNumber(int number) {
    xkcdCurrentNumber = number; // sets the number
    xkcdApiURL =
        'https://xkcd.com/${xkcdCurrentNumber.toString()}/info.0.json'; // updates the URL
  }

  String getXkcdTitle() {
    return xkcdTitle;
  }

  String getXkcdImgURL() {
    return xkcdImgURL;
  }

  String getXkcdAltText() {
    return xkcdAltText;
  }

  int getXkcdCurrentNumber() {
    return xkcdCurrentNumber;
  }

  int getXkcdLatestNumber() {
    return xkcdLatestNumber;
  }

  Future getXkcdData() async {
    // Create response object
    http.Response response;
    // Call API
    response = await http.get(xkcdApiURL);

    // Check the status code to see if it worked
    if (response.statusCode == 200) {
      String data = response.body; // save body contents on string variable

      return jsonDecode(data);
    } else {
      // print the status code to see what happened
      print(response.statusCode);
    }
  }
}
