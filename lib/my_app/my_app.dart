import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth2/pages/home_page.dart';
import 'package:firebase_auth2/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../pages/register_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, user){
          if(user.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(user.hasData){
            return const LoginPage();
          }else{
            return const RegisterPage();
          }
          }
      );
  }
}

