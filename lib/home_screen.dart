//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
// class _HomeScreenState extends State<HomeScreen> {
//   late Uint8List originalImage; // Store the original image
//   bool _isSaving = true;
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthState();
//     // Initialize originalImage with the current image when the screen is first loaded
//     originalImage = Provider.of<AppImageProvider>(context, listen: false).currentImage!;
//
//   }
//   void _revertImage() {
//     final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     // Revert the image to its original state
//     appImageProvider.updateImage(originalImage);
//   }
//
//   void _saveImageToGalleryhd(BuildContext context) async {
//     final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     if (appImageProvider.currentImage != null) {
//       try {
//         // Upload the image to cloud storage (Firebase Storage)
//         final firebase_storage.Reference storageRef =
//         firebase_storage.FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//         final firebase_storage.UploadTask uploadTask = storageRef.putData(
//           Uint8List.fromList(appImageProvider.currentImage!),
//           firebase_storage.SettableMetadata(contentType: 'image/png'),
//         );
//         await uploadTask;
//
//         // Get download URL of the uploaded image
//         final String downloadURL = await storageRef.getDownloadURL();
//         print(downloadURL);
//
//         // Save the image to the device's gallery
//         final result = await ImageGallerySaver.saveImage(Uint8List.fromList(appImageProvider.currentImage!),
//           name: 'my_image.png',quality: 100,);
//         print(result);
//
//         // Save the download URL to Firestore
//         final user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           throw Exception('User not authenticated');
//         }
//         final DateTime uploadTime = DateTime.now();
//         final userId = user.uid;
//         final userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('images');
//         await userRef.add({
//           'imageUrl': downloadURL,
//           'uploadTime': uploadTime.toIso8601String(),
//
//         });
//
//         // Show a snackbar to indicate success
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Image saved Gallery'),
//         ));
//       } catch (e) {
//         // Handle any errors that occur during the process
//         print('Error saving image: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save image'),
//           ),
//         );
//       }
//     } else {
//       // Show a snackbar if there is no image to save
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No image to save'),
//         ),
//       );
//     }
//   }
//   void _saveImageToGallery(BuildContext context) async {
//     final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     if (appImageProvider.currentImage != null) {
//       try {
//         setState(() {
//           _isSaving = true; // Set _isSaving to true before saving
//         });
//
//         // Upload the image to cloud storage (Firebase Storage)
//         final firebase_storage.Reference storageRef =
//         firebase_storage.FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//         final firebase_storage.UploadTask uploadTask = storageRef.putData(
//           Uint8List.fromList(appImageProvider.currentImage!),
//           firebase_storage.SettableMetadata(contentType: 'image/png'),
//         );
//         await uploadTask;
//
//         // Get download URL of the uploaded image
//         final String downloadURL = await storageRef.getDownloadURL();
//         print(downloadURL);
//
//         // Save the image to the device's gallery
//         final result = await ImageGallerySaver.saveImage(Uint8List.fromList(appImageProvider.currentImage!),
//           name: 'my_image.png',quality: 60,);
//         print(result);
//
//         // Save the download URL to Firestore
//         final user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           throw Exception('User not authenticated');
//         }
//         final DateTime uploadTime = DateTime.now();
//         final userId = user.uid;
//         final userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('images');
//         await userRef.add({
//           'imageUrl': downloadURL,
//           'uploadTime': uploadTime.toIso8601String(),
//         });
//
//         // Show a snackbar to indicate success
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Image saved Gallery'),
//         ));
//       } catch (e) {
//         // Handle any errors that occur during the process
//         print('Error saving image: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save image'),
//           ),
//         );
//       } finally {
//         setState(() {
//           _isSaving = false; // Set _isSaving to false after saving
//         });
//       }
//     } else {
//       // Show a snackbar if there is no image to save
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No image to save'),
//         ),
//       );
//     }
//   }
//   /**/
//   // void _saveImageToFirebaseStorage(BuildContext context) async {
//   //   final appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   //   if (appImageProvider.currentImage != null) {
//   //     try {
//   //       // Save the image to Firebase Storage
//   //       final Uint8List imageData = Uint8List.fromList(appImageProvider.currentImage!);
//   //       final String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
//   //       final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images').child(imageName);
//   //       final UploadTask uploadTask = firebaseStorageRef.putData(imageData);
//   //
//   //       uploadTask.whenComplete(() async {
//   //         final String imageUrl = await firebaseStorageRef.getDownloadURL();
//   //
//   //         // Show a snackbar to indicate that the image has been saved to Firebase Storage
//   //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //           content: Text('Image saved to Firebase Storage'),
//   //         ));
//   //       }).catchError((error) {
//   //         // Show a snackbar if saving failed
//   //         print('Error saving image to Firebase Storage: $error');
//   //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //           content: Text('Failed to save image to Firebase Storage'),
//   //         ));
//   //       });
//   //     } catch (e) {
//   //       // Handle any errors that occur during the saving process
//   //       print('Error saving image: $e');
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text('Failed to save image to Firebase Storage'),
//   //       ));
//   //     }
//   //   } else {
//   //     // Show a snackbar to indicate that there is no image to save
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text('No image to save'),
//   //     ));
//   //   }
//   // }
//   late User? _user;
//   void _checkAuthState() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user != null) {
//         // User is signed in
//         setState(() {
//           _user = user;
//         });
//         //_saveImageToGallery();
//       } else {
//         // User is signed out
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginPage()),
//         );
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     //this for specific page to navigate
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Enhance()));
//         return false;
//       },
//       child: GestureDetector(
//         onTap: _revertImage,
//         child: Scaffold(
//           backgroundColor: Color(0xff212121),
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             title: Text(
//               "Photo Editor",
//               style: TextStyle(color: Colors.white),
//             ),
//             // centerTitle: true,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Enhance()));
//               },
//               icon: Icon(Icons.close, color: Colors.white),
//             ),
//             actions: [
//
//               GestureDetector(
//                 onTap: (){
//                   // _saveImageToGallery(context);
//                   _showSaveOptions(context);
//                 },
//                   child: Container(
//                     height: 25,
//                     width: 55,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                           "save",style:
//                       TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 13)),
//                     ),
//                   )),
//               SizedBox(width: 14,),
//               // GestureDetector(
//               //     onTap: (){
//               //       _saveImageToGalleryhd(context);
//               //     },
//               //     child: Container(
//               //       height: 25,
//               //       width: 55,
//               //       decoration: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: BorderRadius.circular(10),
//               //       ),
//               //       child: Center(
//               //         child: Text(
//               //             "save hd",style:
//               //         TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 12)),
//               //       ),
//               //     )),
//               // GestureDetector(
//               //   onTap: () {
//               //     // Show premium plan dialog and initiate purchase flow
//               //     // showPremiumPlanDialog(context, () async {
//               //     //   // Callback function to handle purchase result
//               //     //   final success = await upgradeToPremium(); // Assume this function handles the premium upgrade
//               //     //
//               //     //   if (success) {
//               //     //     _saveImageToGalleryhd(context); // Save image in HD after successful premium upgrade
//               //     //   } else {
//               //     //     // Handle failed premium upgrade
//               //     //     showDialog(
//               //     //       context: context,
//               //     //       builder: (context) => AlertDialog(
//               //     //         title: Text("Upgrade Failed"),
//               //     //         content: Text("Your premium upgrade failed. Please try again."),
//               //     //         actions: [
//               //     //           TextButton(
//               //     //             onPressed: () {
//               //     //               Navigator.pop(context);
//               //     //             },
//               //     //             child: Text("OK"),
//               //     //           ),
//               //     //         ],
//               //     //       ),
//               //     //     );
//               //     //   }
//               //     // });
//               //     _saveImageToGalleryhd(context);
//               //   },
//               //   child: Column(
//               //     children: [
//               //       SizedBox(height: 15,),
//               //       Icon(Icons.hd, color: Colors.white,),
//               //       // Text("Save",style: TextStyle(color: Colors.white,fontSize: 13),),
//               //     ],
//               //   ),
//               // ),
//               IconButton(
//                 onPressed: _revertImage,
//                 icon: Icon(Icons.undo, color: Colors.white),
//               ),
//             ],
//           ),
//           body:
//           Stack(
//             children: [
//               // Content of the screen
//               Center(
//                 child:
//                 Consumer<AppImageProvider>(
//                   builder: (BuildContext context, value, Widget? child) {
//                     if (value.currentImage != null) {
//                       return Image.memory(value.currentImage!);
//                     }
//                     return Container(); // Placeholder when no image is present
//                   },
//                 ),
//               ),
//               // Circular indicator overlayed on top of the content
//               if (_isSaving)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//
//           bottomNavigationBar: Container(
//             height: 58,
//             width: double.infinity,
//             color: Colors.black,
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 20,
//                     ),
//                     _BottomButton(
//                         Icons.crop,
//                         'Crop',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => CropScreen()));
//                         }),
//                     _BottomButton(
//                         Icons.filter_vintage_outlined,
//                         'Filter',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
//                         }),
//                     _BottomButton(
//                         Icons.tune,
//                         'Adjust',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => Adjustment_Screen()));
//                         }),
//                     _BottomButton(
//                         Icons.text_fields_sharp,
//                         'Text',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => Text_Screen()));
//                         }),
//                     _BottomButton(
//                         Icons.emoji_emotions,
//                         'Stickers',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => StickerScreen()));
//                         }),
//                     _BottomButton(
//                         Icons.remove,
//                         'Back',
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => NewApiScreen()));
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _BottomButton(IconData icon, String title, {required onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               color: Colors.white,
//             ),
//             Text(
//               title,
//               style: TextStyle(color: Colors.white70),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void showPremiumPlanDialog(BuildContext context, Function() onUpgradeComplete) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Upgrade to Premium"),
//           content: Text("Upgrade to unlock HD image saving and more!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Simulate successful premium upgrade
//                 Navigator.pop(context); // Close dialog
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumPlanScreen())); // Trigger callback function
//               },
//               child: Text("Upgrade Now"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   Future<bool> upgradeToPremium() {
//     // Simulate premium upgrade process
//     return Future.delayed(Duration(seconds: 2), () => true); // Assume upgrade succeeds after 2 seconds
//   }
//   void _showSaveOptions(BuildContext context) {
//     final RenderBox button = context.findRenderObject() as RenderBox;
//     final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
//
//     final Offset buttonTopRight = button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);
//
//     final RelativeRect position = RelativeRect.fromLTRB(
//       buttonTopRight.dx,
//       buttonTopRight.dy - button.size.height,
//       buttonTopRight.dx + 4, // Adjust the horizontal offset as needed
//       buttonTopRight.dy,
//     );
//
//     showMenu(
//       context: context,
//       position: position,
//       items: [
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.save),
//             title: Text('Save'),
//           ),
//           onTap: () {
//             // Handle save action
//             _saveImageToGallery(context);
//           },
//         ),
//         PopupMenuItem(
//           child: ListTile(
//             leading: Icon(Icons.hd),
//             title: Text('HD Save'),
//           ),
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumPlanScreen()));
//             // _saveImageToGalleryhd(context);
//           },
//         ),
//       ],
//     );
//   }
// }
import 'dart:typed_data';
import 'package:ai_remover_background/crop_image.dart';
import 'package:ai_remover_background/filtter.dart';
import 'package:ai_remover_background/newapi_screen.dart';
import 'package:ai_remover_background/premiumplan_screen.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:ai_remover_background/sticker.dart';
import 'package:ai_remover_background/text_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../login.dart';
import '../screen/enhance.dart';
import 'adjustment_screen.dart';
import 'enhance_second.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Uint8List originalImage;
  bool _isSaving = false;
  @override
  void initState() {
    super.initState();
    _checkAuthState();
    // checkUserStatus();
    originalImage =
    Provider.of<AppImageProvider>(context, listen: false).currentImage!;
  }

  void _revertImage() {
    final appImageProvider =
    Provider.of<AppImageProvider>(context, listen: false);
    // Revert the image to its original state
    appImageProvider.updateImage(originalImage);
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
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
  // Future<void> checkUserStatus() async {
  //   // Get the current user
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     // User is signed in, check their plan purchase status
  //     DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  //     bool hasPremiumPlan = userData.data()?['hasPremiumPlan'] ?? false;
  //
  //     if (hasPremiumPlan) {
  //       // User has purchased a premium plan, navigate to the home screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => Enhance()), // Replace HomeScreen with your authenticated screen
  //       );
  //     } else {
  //       // User has not purchased a premium plan, navigate to the login screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => PremiumPlanScreen()), // Replace LoginScreen with your login screen
  //       );
  //     }
  //   } else {
  //     // User is not signed in, navigate to the login screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => PremiumPlanScreen()), // Replace LoginScreen with your login screen
  //     );
  //   }
  // }

  // void _showSaveOptions(BuildContext context) {
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  //
  //   final Offset buttonTopRight = button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);
  //
  //   final RelativeRect position = RelativeRect.fromLTRB(
  //     buttonTopRight.dx,
  //     buttonTopRight.dy + kToolbarHeight + 40, // Adjust position below app bar
  //     buttonTopRight.dx + 4, // Adjust the horizontal offset as needed
  //     buttonTopRight.dy + kToolbarHeight + 60, // Adjust the total height of the menu by increasing this value
  //   );
  //
  //   showMenu(
  //     context: context,
  //     position: position,
  //     items: [
  //       PopupMenuItem(
  //         child: ListTile(
  //           leading: Icon(Icons.save,color: Colors.black,),
  //           title: Text('Save'),
  //         ),
  //         onTap: () {
  //           // Handle save action
  //           _saveImageToGallery(context);
  //         },
  //       ),
  //       PopupMenuItem(
  //         child: ListTile(
  //           leading: Icon(Icons.hd,color: Colors.black),
  //           title: Text('HD Save'),
  //         ),
  //         onTap: () {
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPlanScreen()));
  //          // _saveImageToGalleryhd(context);
  //         },
  //       ),
  //     ],
  //   );
  // }
  Future<bool> isPremiumPlanPurchased() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();
    return snapshot.exists &&
        snapshot.data()?['premium_plan_purchased'] == true;
  }

  Future<void> markPremiumPlanAsPurchased() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated, handle accordingly
      return;
    }
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'premium_plan_purchased': true,
    }, SetOptions(merge: true));
  }

  void _showSaveOptions(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
    Overlay.of(context)!.context.findRenderObject() as RenderBox;

    final Offset buttonTopRight = button
        .localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);

    final RelativeRect position = RelativeRect.fromLTRB(
      buttonTopRight.dx,
      buttonTopRight.dy + kToolbarHeight + 40,
      buttonTopRight.dx + 4,
      buttonTopRight.dy + kToolbarHeight + 60,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.save, color: Colors.black),
            title: Text('Save'),
          ),
          onTap: () {
            // Handle save action
            _saveImageToGallery(context);
          },
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.hd, color: Colors.black),
            title: Text('HD Save'),
          ),
          onTap: () async {
            // Navigate to PremiumPlanScreen
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPlanScreen())).then((value) {
            //   // Handle result from PremiumPlanScreen
            //   if (value == true) {
            //     // Premium plan purchased, proceed with HD save
            //     _saveImageToGalleryhd(context);
            //   } else {
            //     // Premium plan not purchased
            //     Fluttertoast.showToast(
            //       msg: "Premium plan not purchased.",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.BOTTOM,
            //       backgroundColor: Colors.red,
            //       textColor: Colors.white,
            //     );
            //   }
            // });
            bool isPurchased = await isPremiumPlanPurchased();
            if (isPurchased) {
              // Premium plan purchased, proceed with HD save
              _saveImageToGalleryhd(context);
            } else {
              // Premium plan not purchased
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PremiumPlanScreen()))
                  .then((value) async {
                // Handle result from PremiumPlanScreen
                if (value == true) {
                  // Premium plan purchased, proceed with HD save
                  await markPremiumPlanAsPurchased();
                  _saveImageToGalleryhd(context);
                } else {
                  // Premium plan not purchased
                  Fluttertoast.showToast(
                    msg: "Premium plan not purchased.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              });
            }
          },
        ),
      ],
    );
  }

  void _saveImageToGallery(BuildContext context) async {
    final appImageProvider =
    Provider.of<AppImageProvider>(context, listen: false);
    if (appImageProvider.currentImage != null) {
      try {
        setState(() {
          _isSaving = true; // Set _isSaving to true before saving
        });
        // Upload the image to cloud storage (Firebase Storage)
        final firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
        final firebase_storage.UploadTask uploadTask = storageRef.putData(
          Uint8List.fromList(appImageProvider.currentImage!),
          firebase_storage.SettableMetadata(contentType: 'image/png'),
        );
        await uploadTask;
        // Get download URL of the uploaded image
        final String downloadURL = await storageRef.getDownloadURL();
        print(downloadURL);
        // Save the image to the device's gallery
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(appImageProvider.currentImage!),
          name: 'my_image.png',
          quality: 60,
        );
        print(result);

        // Save the download URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception('User not authenticated');
        }
        final DateTime uploadTime = DateTime.now();
        final userId = user.uid;
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('images');
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
      } finally {
        setState(() {
          _isSaving = false; // Set _isSaving to false after saving
        });
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

  void _saveImageToGalleryhd(BuildContext context) async {
    final appImageProvider =
    Provider.of<AppImageProvider>(context, listen: false);
    if (appImageProvider.currentImage != null) {
      try {
        setState(() {
          _isSaving = true; // Set _isSaving to true before saving
        });

        // Upload the image to cloud storage (Firebase Storage)
        final firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
        final firebase_storage.UploadTask uploadTask = storageRef.putData(
          Uint8List.fromList(appImageProvider.currentImage!),
          firebase_storage.SettableMetadata(contentType: 'image/png'),
        );
        await uploadTask;

        // Get download URL of the uploaded image
        final String downloadURL = await storageRef.getDownloadURL();
        print(downloadURL);

        // Save the image to the device's gallery
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(appImageProvider.currentImage!),
          name: 'my_image.png',
          quality: 100,
        );
        print(result);

        // Save the download URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception('User not authenticated');
        }
        final DateTime uploadTime = DateTime.now();
        final userId = user.uid;
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('images');
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
      } finally {
        setState(() {
          _isSaving = false; // Set _isSaving to false after saving
        });
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

  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
    // print('$h,height');
    // print(w);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Enhance()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff212121),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Photo Editor",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Enhance()));
            },
            icon: Icon(Icons.close, color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _showSaveOptions(context);
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            IconButton(
              onPressed: _revertImage,
              icon: Icon(Icons.undo, color: Colors.white),
            ),
          ],
          bottom: _isSaving
              ? PreferredSize(
              child: LinearProgressIndicator(),
              preferredSize: Size.fromHeight(4))
              : null,
        ),
        body: Stack(
          children: [
            Center(
              child: Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.currentImage != null) {
                    return Image.memory(value.currentImage!);
                  }
                  return Container(); // Placeholder when no image is present
                },
              ),
            ),
            if (_isSaving)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
        bottomNavigationBar: Container(
          // height: 58,
          height: 110,
          width: double.infinity,
          color: Colors.black,
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      _BottomButton(Icons.crop, 'Crop', onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CropScreen()));
                      }),
                      _BottomButton(Icons.filter_vintage_outlined, 'Filter',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FilterScreen()));
                          }),
                      _BottomButton(Icons.tune, 'Adjust', onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Adjustment_Screen()));
                      }),
                      _BottomButton(Icons.text_fields_sharp, 'Text',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Text_Screen()));
                          }),
                      _BottomButton(Icons.emoji_emotions, 'Stickers',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StickerScreen()));
                          }),
                      _BottomButton(Icons.remove, 'Back', onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewApiScreen1()));
                      }),
                    ],
                  ),
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