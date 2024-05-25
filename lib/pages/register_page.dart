import 'package:firebase_auth2/models/user_model.dart';
import 'package:firebase_auth2/pages/confirmation_page.dart';
import 'package:firebase_auth2/pages/login_page.dart';
import 'package:firebase_auth2/services/authentication_service.dart';
import 'package:firebase_auth2/services/http_service.dart';
import 'package:firebase_auth2/services/path_service.dart';
import 'package:firebase_auth2/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController sureNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            textField("Name", nameC),

            const SizedBox(height: 10),

            textField("Surname", sureNameC),

            const SizedBox(height: 10),

            textField("Email", emailC),

            const SizedBox(height: 10),

            textField("Password", passwordC),

            const SizedBox(height: 10),

            textField("Confirm Password", confirmC),

            const SizedBox(height: 10),

            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>const LoginPage()
                    )
                );
              },

              child: const Text(
                "Already have an account? Log in here",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
            ),

            const SizedBox(height: 20),

            MaterialButton(
              onPressed: ()async{
                UserModel user = UserModel(
                    password: passwordC.text,
                    email: emailC.text,
                    name: nameC.text
                );

                await HttpService.post(context, user);
                await PathService.saveData(user);
                await AuthenticationService.registerUser(
                    name: nameC.text,
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
              color: Colors.blue,
              shape: const StadiumBorder(),
              minWidth: 340,
              height: 50,
              child: const Text(
                "Register",
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
