/*
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ai_remover_background/adjustment_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class FilterSecondScreen extends StatefulWidget {
  late final File imageFile;
  final ui.Image? filteredImage;

  FilterSecondScreen({Key? key, required this.imageFile, this.filteredImage})
      : super(key: key);

  @override
  State<FilterSecondScreen> createState() => _FilterSecondScreenState();
}

class _FilterSecondScreenState extends State<FilterSecondScreen> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  // Function to check the authentication state
  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        setState(() {
          _user = user;
        });
      } else {
        // User is signed out
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  Future<void> _saveImageToGallery() async {
    try {
      final success = await ImageGallerySaver.saveFile(widget.imageFile.path);
      print(success);
      if (success) {
        Fluttertoast.showToast(
          msg: 'Image saved to gallery',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to save image',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to save image: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }
      final DateTime uploadTime = DateTime.now(); // Get current DateTime
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child('image_${uploadTime.microsecondsSinceEpoch}.jpg'); // Use microseconds for unique filenames
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': widget.imageFile.path});

      final UploadTask uploadTask = ref.putFile(
        widget.imageFile,
        metadata,
      );
      await uploadTask
          .whenComplete(() => print('Image uploaded to Firebase'));
      final String downloadURL = await ref.getDownloadURL();
      final userId = user.uid;
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('images');
      await userRef.add({
        'imageUrl': downloadURL,
        'uploadTime': uploadTime.toIso8601String(), // Store upload time as ISO 8601 string
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to upload image: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<File?> cropImage(File imageFile) async {
    File? cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        cropGridColor: Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Crop',
        aspectRatioLockEnabled: false,
        rotateButtonsHidden: false,
        rotateClockwiseButtonHidden: false,
      ),
    );
    return cropped;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.filteredImage != null &&
                      widget.filteredImage is File
                      ? Image.file(
                    widget.filteredImage as File,
                    fit: BoxFit.cover,
                  )
                      : Image.file(
                    widget.imageFile,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cropImage(File(widget.imageFile as String));
                  },
                  child: Text("Crop Image"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdjustmentScreen(
                          orignalimageFile: widget.imageFile,
                          imageFile: widget.imageFile,
                        ),
                      ),
                    );
                  },
                  child: Text("Adjustment"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add filters functionality here
                  },
                  child: Text("Filters"),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkAuthState();
                _saveImageToGallery();
              },
              child: Text("Save Image"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
