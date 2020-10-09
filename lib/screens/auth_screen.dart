import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'login.dart';


class AuthScreen extends StatefulWidget {
  String otp;

  AuthScreen({this.otp});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String otpdata;
  String smsOTP;
  int pinLength = 6;
  bool hasError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

//Otp verification
  dynamic signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verify,
        smsCode:smsOTP,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((AuthResult user) async {
        showAlertDialog(context, "Success", "Register Success", "Done");
        print('Signed in with phone number successful');
      });
    } on PlatformException catch (e) {
      showAlertDialogFailed(context, "Failed", "Oops!!", "Ok");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Auth'),
          backgroundColor: Colors.red,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: PinCodeTextField(
                  highlightColor: Colors.grey,
                  defaultBorderColor: Colors.grey,
                  hasTextBorderColor: Colors.grey,
                  autofocus: false,
                  hideCharacter: true,
                  highlight: true,
                  pinBoxHeight: 50,
                  pinBoxWidth: 50,
                  controller: controller,
                  maxLength: pinLength,
                  hasError: hasError,
                  maskCharacter: '*',
                  onTextChanged: (text) {
                    if (text.length == 6) {
                      otpdata = text;
                      smsOTP = text;
                    }
                  },
                  pinBoxRadius: 5,
                  onDone: (text) {},
                  wrapAlignment: WrapAlignment.start,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 25.0, color: Colors.black),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration:
                      const Duration(milliseconds: 300),
                ),
              ),
              Visibility(
                child: const Text(
                  'Wrong PIN!',
                  style: TextStyle(color: Colors.red),
                ),
                visible: hasError,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () {
                    signIn();
                  },
                  color: Colors.redAccent,
                  child: Text('Auth'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialogFailed(BuildContext context,String title, String description,String buttonName) {
    // Create button
    Widget okButton = FlatButton(
      child: Text(buttonName),
      onPressed: () {
       Navigator.pop(context);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context,String title, String description,String buttonName) {
    // Create button
    Widget okButton = FlatButton(
      child: Text(buttonName),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
