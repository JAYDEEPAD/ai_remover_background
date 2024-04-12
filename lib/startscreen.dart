
import 'package:ai_remover_background/enhance_second.dart';
import 'package:ai_remover_background/home_screen.dart';
import 'package:ai_remover_background/image_picker.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
void main(){
  runApp(StartScreen());
}

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late AppImageProvider appImageProvider;

  @override
  void initState() {
    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Enhance()));
        },child: Icon(Icons.arrow_back_outlined),),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/img_7.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ImagePicker1(source: ImageSource.gallery).pick(
                        onPick: (File? image) {
                          if (image != null) {
                            appImageProvider.changeImageFile(image);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                        },
                      );
                    },
                    child: Text("Gallery"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      ImagePicker1(source: ImageSource.camera).pick(
                        onPick: (File? image) {
                          if (image != null) {
                            appImageProvider.changeImageFile(image);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                        },
                      );
                    },
                    child: Text("Camera"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


