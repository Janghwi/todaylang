import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'google_signin_prov.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            FlutterLogo(size: 120),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey There,\nWelcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login to your account to continue',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.email_outlined),
              label: Text('Sign Up with Email'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: Size(double.infinity, 100),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 180),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              label: Text(
                'Sign Up with Google',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                children: const [
                  TextSpan(
                    text: 'Log in',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      );
}
