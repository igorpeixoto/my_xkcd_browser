import 'package:flutter/material.dart';
import 'package:xkcd_browser/utilities/constants.dart';

class MyButton extends StatelessWidget {
  // Attributes
  final String label;
  final Icon icon;
  final Function onPressed;
  final int flex;

  // Constructor
  MyButton({
    @required this.label,
    @required this.icon,
    @required this.onPressed,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: RaisedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(label),
          color: kButtonColor,
        ),
      ),
    );
  }
}
