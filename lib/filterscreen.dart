import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ai_remover_background/Imagehelper.dart';
import 'package:ai_remover_background/adjustment_screen.dart';
import 'package:ai_remover_background/login.dart';
import 'package:ai_remover_background/second_home.dart';

class FilterPage extends StatefulWidget {
  File imageFile;
  final ColorFilter selectedFilter;

  FilterPage({Key? key, required this.imageFile, required this.selectedFilter}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      } else {
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
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to gallery')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image')),
      );
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final DateTime uploadTime = DateTime.now();
      final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('image_${uploadTime.microsecondsSinceEpoch}.jpg');
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': widget.imageFile.path});

      final firebase_storage.UploadTask uploadTask = ref.putFile(
        widget.imageFile,
        metadata,
      );
      await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));
      final String downloadURL = await ref.getDownloadURL();
      final userId = user.uid;

      final userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('images');

      await userRef.add({
        'imageURL': downloadURL,
        'uploadTime': uploadTime.toIso8601String(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[200],
          title: Text(
            "Edit Photo",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _checkAuthState();
                _saveImageToGallery();
              },
              icon: Icon(Icons.download_for_offline),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
        child: Column(
        children: [
        SizedBox(height: 50),
    Center(
    child: Container(
    color: Colors.yellow,
    height: MediaQuery.of(context).size.height * 0.50,
    width: MediaQuery.of(context).size.width * 0.70,
    child: ColorFiltered(
    colorFilter: widget.selectedFilter,
    child: Image.file(widget.imageFile, fit: BoxFit.cover),
    ),
    ),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    SizedBox(width: 20),
    Center(
    child: Column(
    children: [
    Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(10),
    child: Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
    onPressed: () async {
    if (widget.imageFile != null) {
    File? cropped = await ImageHelper.cropImage(widget.imageFile);
    if (cropped != null) {
    setState(() {
    widget.imageFile = cropped;
    });
    }
    }
    },
    icon: Icon(Icons.crop, color: Colors.white),
    ),
    ),
    ),
    Text("Crop", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
    ],
    ),
    ),
    SizedBox(width: 15),
    Center(
    child: Column(
    children: [
    Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(10),
    child: Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdjustmentScreen(orignalimageFile: widget.imageFile)));
    },
    icon: Icon(Icons.adjust, color: Colors.white),
    ),
    ),
    ),
    Text("Adjustment", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
    ],
    ),
    ),
    SizedBox(width: 15),
    Center(
    child: Column(
    children: [
    Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(10),
    child: Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
    onPressed: () {
    // Navigate to filter screen with the selected filter
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => FilterPage(
    imageFile: widget.imageFile,
    selectedFilter: widget.selectedFilter,
    ),
    ),
    );
    },
    icon: Icon(Icons.filter, color: Colors.white),
    ),
    ),
    ),
    Text("Filters", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
    ],
    ),
    ),
      SizedBox(width: 15),
      Center(
        child: Column(
          children: [
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondHome()));
                  },
                  icon: Icon(Icons.backpack_outlined, color: Colors.white),
                ),
              ),
            ),
            Text("Background", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      SizedBox(width: 10),
    ],
    ),
        ],
        ),
        ),
    );
  }
}
