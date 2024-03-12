import 'dart:io';

import 'package:ai_remover_background/Imagehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photofilters/photofilters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class Filters extends StatefulWidget {
  File imageFile;
  Filters({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {

  Future<void> _saveImageToGallery() async {
    try {
      final success = await ImageGallerySaver.saveFile(widget.imageFile.path);
      print(success);
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
        SnackBar(content: Text('Failed to save image: $e')),
      );
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      print(user);
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');
           print(ref.getDownloadURL());
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': widget.imageFile.path});

      final UploadTask uploadTask = ref.putFile(
        widget.imageFile,
        metadata,
      );
      await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));
      final String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      final userId = user.uid;
      print(userId);// Replace 'user_id' with the actual user ID
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
       print(userRef);
      await userRef.set({'imageURL': downloadURL});
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
        title: Text("filter Screen"),
      ),
      body: Column(
        children: [
          Center(child: Image.file(widget.imageFile, height: 320, width: 320)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Center(
                child: Column(
                  children: [
                    Container(
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
                    Text("Crop", style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
              // Add adjustment and filters widgets here
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Add adjustment functionality here
                        },
                        icon: Icon(Icons.adjust, color: Colors.white),
                      ),
                    ),
                    Text("Adjustment", style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          
                          // Add filters functionality here
                        },
                        icon: Icon(Icons.filter, color: Colors.white),
                      ),
                    ),
                    Text("Filters", style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: _saveImageToGallery,
                        icon: Icon(Icons.save, color: Colors.white),
                      ),
                    ),
                    Text("Save", style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
