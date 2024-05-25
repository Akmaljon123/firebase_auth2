import 'package:firebase_auth2/my_app/my_app.dart';
import 'package:firebase_auth2/my_app/setup.dart';
import 'package:flutter/material.dart';

void main()async{
  await setup();
  runApp(const MyApp());
}