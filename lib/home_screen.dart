// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:projects/screen/enhance.dart';
// import 'package:projects/widgets/cropscren.dart';
//
// import 'package:projects/widgets/provider.dart';
// import 'package:provider/provider.dart';
//
// import '../startscreen.dart';
// import 'adjustment_screen.dart';
// import 'fitler_screen.dart';
// import 'package:gallery_saver/gallery_saver.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   void _saveImageToGallery() async {
//     final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     if (appImageProvider.currentImage != null) {
//       try {
//         // Save the image to the gallery
//         final result = await ImageGallerySaver.saveImage(
//           Uint8List.fromList(appImageProvider.currentImage!),
//           quality: 80, // Adjust quality as needed
//         );
//
//         if (result['isSuccess']) {
//           // Show a snackbar to indicate that the image has been saved
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Image saved to gallery'),
//           ));
//         } else {
//           // Show a snackbar if saving failed
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Failed to save image to gallery'),
//           ));
//         }
//       } catch (e) {
//         // Handle any errors that occur during the saving process
//         print('Error saving image: $e');
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to save image to gallery'),
//         ));
//       }
//     } else {
//       // Show a snackbar to indicate that there is no image to save
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('No image to save'),
//       ));
//     }
//   }
//
//   // void _saveImageToFirebase() async {
//   //   final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   //   if (appImageProvider.currentImage != null) {
//   //     try {
//   //       // Save the image to Firebase Storage
//   //       final Reference ref = FirebaseStorage.instance.ref().child('images').child(DateTime.now().toString() + '.jpg');
//   //       final UploadTask uploadTask = ref.putData(
//   //         Uint8List.fromList(appImageProvider.currentImage!),
//   //         SettableMetadata(contentType: 'image/jpeg'), // Set metadata including content type
//   //       );
//   //       await uploadTask.whenComplete(() async {
//   //         // Get download URL for the uploaded image
//   //         final String imageUrl = await ref.getDownloadURL();
//   //
//   //         // Store additional metadata like date of upload
//   //         final Map<String, dynamic> imageMetadata = {
//   //           'imageUrl': imageUrl,
//   //           'uploadDate': Timestamp.now(), // Firestore timestamp
//   //         };
//   //
//   //         // Save metadata to Firestore
//   //         await FirebaseFirestore.instance.collection('images').add(imageMetadata);
//   //
//   //         // Show a snackbar to indicate successful save
//   //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //           content: Text('Image saved to Firebase'),
//   //         ));
//   //       });
//   //     } catch (e) {
//   //       // Handle any errors that occur during the saving process
//   //       print('Error saving image: $e');
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text('Failed to save image to Firebase'),
//   //       ));
//   //     }
//   //   } else {
//   //     // Show a snackbar if there is no image to save
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text('No image to save'),
//   //     ));
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff212121),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text("Photo Editor",style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Enhance()));
//             },
//             icon: Icon(Icons.close,color: Colors.white,)),
//         actions: [
//           TextButton(onPressed: _saveImageToGallery, child: Text("Save"),),
//         ],
//       ),
//       body: Center(
//         child: Consumer<AppImageProvider>(
//             builder: (BuildContext context, value, Widget? child) {
//           if (value.currentImage != null) {
//             return Image.memory(value.currentImage!);
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }),
//       ),
//       bottomNavigationBar: Container(
//         height: 58,
//         width: double.infinity,
//         color: Colors.black,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 _BottomButton(
//                   Icons.crop,
//                   'Crop',
//                   onPressed:(){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CropScreen()));
//                   }
//                 ),
//                 _BottomButton(
//                     Icons.filter_vintage_outlined,
//                     'Filter',
//                     onPressed:(){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Filter_Screen()));
//                     }
//                 ),
//                 _BottomButton(
//                     Icons.tune,
//                     'Adjust',
//                     onPressed:(){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Adjustment_Screen()));
//                     }
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _BottomButton(IconData icon , String title ,{required onPressed}){
//    return  InkWell(
//      onTap: onPressed,
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//        child: Column(
//          children: [
//            Icon(icon,color: Colors.white,),
//            Text(title,style: TextStyle(color: Colors.white70),),
//          ],
//        ),
//      ),
//    );
//   }
// }
// // rules_version = '2';
// //
// // service cloud.firestore {
// // match /databases/{database}/documents {
// // match /{document=**} {
// // allow read, write: if true;
// // }
// // }
// // }
//
//
//
//
import 'dart:typed_data';
import 'package:ai_remover_background/crop_image.dart';
import 'package:ai_remover_background/filtter.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:ai_remover_background/remove_screen.dart';
import 'package:ai_remover_background/sticker.dart';
import 'package:ai_remover_background/text_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../login.dart';
import '../screen/enhance.dart';
import 'adjustment_screen.dart';
import 'enhance_second.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Uint8List originalImage; // Store the original image
  @override
  void initState() {
    super.initState();
    _checkAuthState();
    // Initialize originalImage with the current image when the screen is first loaded
    originalImage = Provider.of<AppImageProvider>(context, listen: false).currentImage!;

  }

  void _revertImage() {
    final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    // Revert the image to its original state
    appImageProvider.updateImage(originalImage);
  }

  void _saveImageToGallery(BuildContext context) async {
    final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    if (appImageProvider.currentImage != null) {
      try {
        // Upload the image to cloud storage (Firebase Storage)
        final firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');
        final firebase_storage.UploadTask uploadTask = storageRef.putData(
          Uint8List.fromList(appImageProvider.currentImage!),
          firebase_storage.SettableMetadata(contentType: 'image/png'),
        );
        await uploadTask;

        // Get download URL of the uploaded image
        final String downloadURL = await storageRef.getDownloadURL();
        print(downloadURL);

        // Save the image to the device's gallery
        final result = await ImageGallerySaver.saveImage(Uint8List.fromList(appImageProvider.currentImage!), name: 'my_image.png');
        print(result);

        // Save the download URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception('User not authenticated');
        }
        final DateTime uploadTime = DateTime.now();
        final userId = user.uid;
        final userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('images');
        await userRef.add({
          'imageUrl': downloadURL,
          'uploadTime': uploadTime.toIso8601String(),
        });

        // Show a snackbar to indicate success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image saved Gallery'),
        ));
      } catch (e) {
        // Handle any errors that occur during the process
        print('Error saving image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save image'),
          ),
        );
      }
    } else {
      // Show a snackbar if there is no image to save
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image to save'),
        ),
      );
    }
  }

  /**/
  // void _saveImageToFirebaseStorage(BuildContext context) async {
  //   final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  //   if (appImageProvider.currentImage != null) {
  //     try {
  //       // Save the image to Firebase Storage
  //       final Uint8List imageData = Uint8List.fromList(appImageProvider.currentImage!);
  //       final String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //       final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images').child(imageName);
  //       final UploadTask uploadTask = firebaseStorageRef.putData(imageData);
  //
  //       uploadTask.whenComplete(() async {
  //         final String imageUrl = await firebaseStorageRef.getDownloadURL();
  //
  //         // Show a snackbar to indicate that the image has been saved to Firebase Storage
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text('Image saved to Firebase Storage'),
  //         ));
  //       }).catchError((error) {
  //         // Show a snackbar if saving failed
  //         print('Error saving image to Firebase Storage: $error');
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text('Failed to save image to Firebase Storage'),
  //         ));
  //       });
  //     } catch (e) {
  //       // Handle any errors that occur during the saving process
  //       print('Error saving image: $e');
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Failed to save image to Firebase Storage'),
  //       ));
  //     }
  //   } else {
  //     // Show a snackbar to indicate that there is no image to save
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('No image to save'),
  //     ));
  //   }
  // }
  late User? _user;
  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        setState(() {
          _user = user;
        });
        //_saveImageToGallery();
      } else {
        // User is signed out
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _revertImage,
      child: Scaffold(
        backgroundColor: Color(0xff212121),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Photo Editor",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Enhance()));
            },
            icon: Icon(Icons.close, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: (){
                //   _checkAuthState();
                _saveImageToGallery(context);
              },
              child: Text("Save", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            ),
            IconButton(
              onPressed: _revertImage,
              icon: Icon(Icons.undo, color: Colors.white),
            ),
          ],
        ),
        body: Center(
          child: Consumer<AppImageProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.currentImage != null) {
                return Image.memory(value.currentImage!);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          height: 58,
          width: double.infinity,
          color: Colors.black,
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  _BottomButton(
                      Icons.crop,
                      'Crop',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CropScreen()));
                      }),
                  _BottomButton(
                      Icons.filter_vintage_outlined,
                      'Filter',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
                      }),
                  _BottomButton(
                      Icons.tune,
                      'Adjust',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Adjustment_Screen()));
                      }),
                  _BottomButton(
                      Icons.text_fields_sharp,
                      'Text',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Text_Screen()));
                      }),
                  _BottomButton(
                      Icons.emoji_emotions,
                      'Stickers',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StickerScreen()));
                      }),
                  _BottomButton(
                      Icons.remove,
                      'Back',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewApiScreen()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _BottomButton(IconData icon, String title, {required onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
