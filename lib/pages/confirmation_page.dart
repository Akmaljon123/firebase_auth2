import 'package:firebase_auth2/pages/home_page.dart';
import 'package:firebase_auth2/services/util_service.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationPage extends StatefulWidget {
  String email;
  ConfirmationPage({super.key, required this.email});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  EmailOTP myAuth = EmailOTP();
  String currentText = "";
  TextEditingController controller = TextEditingController();

  Future<void> sendCode() async {
    await myAuth.setConfig(
        appEmail: "akmalahmadjonov798@gmail.com",
        appName: "Email OTP",
        userEmail: widget.email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);

    await myAuth.sendOTP();
  }

  @override
  void initState() {
    sendCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email verification"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PinCodeTextField(
                length: 4,
                cursorColor: Colors.blue,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  activeColor: Colors.blue,
                  selectedColor: Colors.blue,
                  inactiveColor: Colors.blue,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
                appContext: context,
              ),
            ),

            const SizedBox(height: 10),

            MaterialButton(
              onPressed: ()async{
                if(myAuth.verifyOTP(otp: currentText)){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>const HomePage()
                      ),
                          (route)=>false
                  );
                }else{
                  Utils.fireSnackBar("Pin code is incorrect", context);
                }
              },
              color: Colors.blue,
              shape: const StadiumBorder(),
              minWidth: 340,
              height: 50,
              child: const Text(
                "Verify",
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
