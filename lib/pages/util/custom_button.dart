import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  const CustomButton({Key? key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(top: 12, bottom: 12, right: 16, left: 16),
        child: Text(
          text!,
          // ignore: prefer_const_constructors
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
