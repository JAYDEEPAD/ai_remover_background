import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'enhance_second.dart';
import 'login.dart';

class Wraper extends StatefulWidget {
  const Wraper({super.key});

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context ,snapshot){
            if(snapshot.hasData){
                 return Enhance();
            }else{
               return LoginPage();
            }
          }
      ),
    );
  }
}
