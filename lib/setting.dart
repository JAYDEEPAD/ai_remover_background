import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'login.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
   _logout() async {
    await FirebaseAuth.instance.signOut();
     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          _logout();
        }, child: Text("LogOut")),
      ),
    );
  }
}
