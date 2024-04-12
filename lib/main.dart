// import 'package:ai_remover_background/dashbord.dart';
// import 'package:ai_remover_background/splash_screen.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';
// import 'onnbord.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp();
//   runApp(DevicePreview(
//     enabled: true,
//     tools: [
//       ...DevicePreview.defaultTools,
//     ],
//     builder: (context) => MyApp(),
//   ),);
//   //runApp( MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//     //  home: MyHomePage(),
//       //home: DashboardScreen(),
//       home: SplashScreen(),
//     );
//   }
// }
//
//

import 'package:ai_remover_background/profile_page.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:ai_remover_background/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'dashbord.dart';

import 'login.dart';
import 'onnbord.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: true,
    tools: [
      ...DevicePreview.defaultTools,
    ],
    builder: (context) => MyApp(),
  ),);
  //runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>ImageProviderPicker()),
          ChangeNotifierProvider(create: (context)=>AppImageProvider()),

        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,

          // home: MyHomePage(),
          //  home: DashboardScreen(),
          //  home: Wraper(),
          home: SplashScreen(),
        )
    );
  }
}