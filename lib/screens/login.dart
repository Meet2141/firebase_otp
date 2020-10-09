import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';

String verify;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController(text: "+91");


//otp send on button clicked
  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      verify = verId;
      print('Code sent to ${phoneController.text}');
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          codeAutoRetrievalTimeout: (String verId) {
            verify = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}');
          });
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Otp Demo"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: phoneController,
              ),
              RaisedButton(
                onPressed: () async {
                  await verifyPhone();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                },
                color: Colors.redAccent,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }


}
