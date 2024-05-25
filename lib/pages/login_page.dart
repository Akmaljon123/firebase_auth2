import 'package:firebase_auth2/pages/register_page.dart';
import 'package:firebase_auth2/services/authentication_service.dart';
import 'package:firebase_auth2/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'confirmation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            textField("Email", emailC),

            const SizedBox(height: 10),

            textField("Password", passwordC),

            const SizedBox(height: 5),

            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>const RegisterPage()
                    )
                );
              },

              child: const Text(
                  "Do not have an account? Register here",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
            ),

            const SizedBox(height: 15),

            MaterialButton(
              onPressed: ()async{
                await AuthenticationService.signInWithGoogle(context);
              },
              shape: const StadiumBorder(),
              color: Colors.blue,
              height: 60,
              minWidth: 80,
              child: const Text("Google",style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            const SizedBox(height: 20),

            MaterialButton(
              onPressed: ()async{
                await AuthenticationService.loginUser(
                    email: emailC.text,
                    password: passwordC.text
                );

                if(context.mounted){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>ConfirmationPage(email: emailC.text)
                      )
                  );
                }
              },
              shape: const StadiumBorder(),
              minWidth: 340,
              height: 50,
              color: Colors.blue,
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
