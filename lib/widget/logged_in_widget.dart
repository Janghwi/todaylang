import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'google_signin_prov.dart';
import 'homepage.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Logout', style: TextStyle(color: Colors.white)),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Welcome',
              style: TextStyle(fontSize: 24, color: Colors.white54)),
          SizedBox(height: 32),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + user.displayName!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + user.email!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 18),
          TextButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
            ),
            child: Text("메뉴로 이동", style: TextStyle(fontSize: 26)),
            onPressed: () => Get.to(HomePage()),
          )
        ]),
      ),
    );
  }
}