import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
// const simplePeriodicTask = "simplePeriodicTask";
// // flutter local notification setup
// void showNotification(v, flip) async {
//   var android = AndroidNotificationDetails('channel id', 'channel NAME',
//       priority: Priority.high, importance: Importance.max);
//   var iOS = IOSNotificationDetails();
//   var platform = NotificationDetails(android: android, iOS: iOS);
//   await flip.show(0, 'Virtual intelligent solution', '$v', platform,
//       payload: 'VIS \n $v');
// }

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Workmanager().initialize(callbackDispatcher,
// //       isInDebugMode:
// //           true); //to true if still in testing lev turn it to false whenever you are launching the app
// //   await Workmanager().registerPeriodicTask("5", simplePeriodicTask,
// //       existingWorkPolicy: ExistingWorkPolicy.replace,
// //       frequency: Duration(minutes: 15), //when should it check the link
// //       initialDelay:
// //           Duration(seconds: 5), //duration before showing the notification
// //       constraints: Constraints(
// //         networkType: NetworkType.connected,
// //       ));
//   runApp(MyApp());
// }

// // void callbackDispatcher() {
// //   Workmanager().executeTask((task, inputData) async {
// //     FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
// //     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
// //     var iOS = IOSInitializationSettings();
// //     var setttings = InitializationSettings(android: android, iOS: iOS);
// //     flp.initialize(setttings);

// //     List records = [];

// //     Dio dio = Dio();
// //     var response = await dio.get(
// //       "https://api.airtable.com/v0/app95nB2yi0WAYDyn/pushnotifyTbl?maxRecords=10&view=Gridview",
// //       options: Options(contentType: 'Application/json', headers: {
// //         'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
// //         'Accept': 'Application/json',
// //       }),
// //     );
//     print('records passed');

//     Map<String, dynamic> result = (response.data);

//     records = result['records']['fields'];
//     print('==========>');
//     print({records});

//     if (records[0]['sent'] == true) {
//       showNotification(records[0]['message'].toString(), flp);
//     } else {
//       print("no messgae");
//     }

//     //  var response= await http.post('https://seeviswork.000webhostapp.com/api/testapi.php');
//     //  print("here================");
//     //  print(response);
//     //   var convert = json.decode(response.body);
//     //     if (convert['status']  == true) {
//     //       showNotification(convert['msg'], flp);
//     //     } else {
//     //     print("no messgae");
//     //     }

//     return Future.value(true);
//   });
// }

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter notification',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Testing push notification"),
              centerTitle: true,
            ),
            body: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                        "Flutter push notification without firebase with background fetch feature")),
              ),
            )));
  }
}
