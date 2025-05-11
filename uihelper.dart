import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiHelper {
  static Widget CustomTextButton({
    required String text,
    required VoidCallback callback,
    Color textColor = const Color(0xFF3797EF),
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextButton(
      onPressed: callback,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  static Widget CustomTextField({
    required TextEditingController controller,
    required String text,
    required bool tohide,
    Color textColor = Colors.white,
    Color fillColor = const Color(0xFF121212),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)), // ✅ Added
  }) {
    return Container(
      height: 50,
      width: 343,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          controller: controller,
          obscureText: tohide,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(fontSize: 14, color: textColor),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  static Widget CustomImage({required String imgurl}) {
    return Image.asset("assets/images/$imgurl");
  }

  static Widget CustomButton({
    required VoidCallback callback,
    required String buttonname,
    Color backgroundColor = const Color(0xFF3797EF),
    Color textColor = Colors.white,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)), // ✅ Added
  }) {
    return SizedBox(
      height: 45,
      width: 343,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Center(
          child: Text(
            buttonname,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Show Toast Method
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
