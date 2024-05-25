import 'package:flutter/material.dart';

Widget textField(String labelText, TextEditingController controller){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      cursorColor: Colors.white,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}