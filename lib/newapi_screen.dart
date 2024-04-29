import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:ai_remover_background/home_screen.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class NewApiScreen1 extends StatefulWidget {
  const NewApiScreen1({Key? key}) : super(key: key);

  @override
  State<NewApiScreen1> createState() => _NewApiScreenState();
}

class _NewApiScreenState extends State<NewApiScreen1> {
  String? newimageUrl;
  String? errorMessage;
  bool isProcessing = false;
  late AppImageProvider appImageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  Future<void> removeBackground(String downloadUrl) async {
    final apiUrl = 'https://bgremove.dohost.in/remove-bg';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "image_url": downloadUrl,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final imageData = responseData['image_url'];
        print(imageData);
        setState(() {
          newimageUrl = imageData;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to remove background: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to remove background: $e';
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Background Remove Screen",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.close, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () async {
                Uint8List? byte = await screenshotController.capture();
                appImageProvider.changeImage(byte!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.check, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (newimageUrl != null) {
                    return Column(
                      children: [
                        Image.network(
                          newimageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  } else if (value.currentImage != null) {
                    return Column(
                      children: [
                        Image.memory(
                          value.currentImage!,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 100,),
                Consumer<AppImageProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          String imageDataString = base64Encode(value.currentImage!);
                          print(imageDataString);
                          try {
                            String? downloadUrl = await uploadBase64ImageToFirebase(imageDataString);
                            if (downloadUrl != null) {
                              await removeBackground(downloadUrl);
                            }
                          } catch (e) {
                            print("Error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        child: Text('Remove Background'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadBase64ImageToFirebase(String base64String) async {
    try {
      Uint8List bytes = base64.decode(base64String);
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      TaskSnapshot uploadTask = await storageRef.putData(bytes);
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      return null;
    }
  }
}

class Const_value {
  String cdn_url_image_display = "https://cdn.dohost.in//upload//";
  String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
}
