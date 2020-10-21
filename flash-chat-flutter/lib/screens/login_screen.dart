import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/animation_constants.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/routes.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: HeroTags.logoIcon,
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                )
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    inAsyncCall = true;
                  });

                  try {
                    final credentials = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (credentials != null) {
                      Navigator.pushNamed(context, Routes.chatScreen);
                    }
                  } catch (e) {
                    print(e);
                  } finally {
                    setState(() {
                      inAsyncCall = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        inAsyncCall: inAsyncCall,
      ),
    );
  }
}
