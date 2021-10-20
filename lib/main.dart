import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todaylang/page/commentlist.dart';
import 'package:todaylang/widget/homepage.dart';

import 'page/first_screen_ad.dart';
import 'page/first_screen_ai.dart';
import 'page/first_screen_dt.dart';
import 'page/first_screen_md1.dart';
import 'page/first_screen_of.dart';
import 'page/first_screen_wb.dart';
import 'page/first_screen_wb1.dart';
import 'page/first_screen_yt.dart';
import 'page/first_screen_ytLan.dart';
import 'widget/google_signin_prov.dart';
import 'widget/logged_in_widget.dart';
import 'widget/sign_up_widget.dart';
import 'widget/tabbar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = '좋은생각';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                primary: Colors.white,
                shape: CircleBorder(),
                minimumSize: Size.square(30),
              ),
            ),
          ),
          home: LoginPage(),
          // home: HomePage(),
        ),
      );
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return LoggedInWidget();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went Wrong!'));
            } else {
              // return HomePage();
              return SignUpWidget();
            }
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   onTap: (index) {
        //     print(index);
        //   },
        //   backgroundColor: Colors.white,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //     BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Messages"),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        //   ],
        // ),
      );
}
