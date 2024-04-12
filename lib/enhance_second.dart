import 'dart:io';
import 'dart:typed_data';
import 'package:ai_remover_background/screen/Filters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../filtter.dart';
import '../profile_page.dart';
import '../second_home.dart';
import '../setting.dart';
import '../startscreen.dart';

import 'download.dart';
import 'home_screen.dart';
import 'image_picker.dart';
import 'provider.dart';

class Enhance extends StatefulWidget {
  @override
  State<Enhance> createState() => _EnhanceState();
}
class _EnhanceState extends State<Enhance> {
  List<dynamic> storageImages = [];
  late AppImageProvider appImageProvider;
  String? userName;
  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user
          .reload(); // Reload the user to get the latest data including the display name
      setState(() {
        userName = user.displayName;
      });
    }
  }
  File? _image;
  Future getImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  Future<void> fetchImages() async {
    // Fetch products from Firestore
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('images').get();
    print(querySnapshot);
    setState(() {
      storageImages = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
  Future<String> getImageUrl(String imagePath) async {
    // Get download URL from Firebase Storage
    String downloadURL =
    await FirebaseStorage.instance.ref().child(imagePath).getDownloadURL();
    debugPrint(downloadURL.toString());
    return downloadURL;
  }
  @override
  void initState() {
    super.initState();
    fetchImages();
    fetchUserName();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);

  }
  List products = [
    {
      "Product_name": "AI Avatar Generator",
      "price": "\$200",
      "image_path": 'assets/images/ai1.png'
    },
    {
      "Product_name": "AI Scene Generator",
      "price": "\$200",
      "image_path": 'assets/images/ai2.png'
    },
    {
      "Product_name": "AI Anime Generator",
      "price": "\$200",
      "image_path": 'assets/images/ai3.png'
    },
    {
      "Product_name": "AI Cartoonizer",
      "price": "\$200",
      "image_path": 'assets/images/ai4.png'
    },
    {
      "Product_name": "AI Generator",
      "price": "\$200",
      "image_path": 'assets/images/ai5.png'
    },
    {
      "Product_name": "AI Generator",
      "price": "\$200",
      "image_path": 'assets/images/ai6.png'
    },
    // {"Product_name":"AI  Generator","price":"\$200" ,"image_path":'assets/images/1.png'},
  ];
  Future<void> _downloadImage(String imageURL) async {
    try {
      // Fetch the image bytes from the network
      final http.Response response = await http.get(Uri.parse(imageURL));
      final Uint8List bytes = response.bodyBytes;

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(bytes);

      if (result != null) {
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
        SnackBar(content: Text('Error saving image: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Uint8List? _image = context.watch<ImageProviderPicker>().image;
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                  // CircleAvatar(
                  //     radius:25,
                  //     backgroundImage:AssetImage("assets/images/ai1.png")
                  // ),
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    child: Stack(children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 25,
                        backgroundImage: MemoryImage(_image!),
                      )
                          : CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2024/03/06/18/46/ai-generated-8616945_640.jpg'),
                        radius: 24,
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Column(
                    children: [
                      Text(
                        "Welcome back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 7,
                          ),
                          Text("Khushali Sarvaiya"),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(width: 30,),
                  Spacer(),

                  Row(
                    children: [
                      //this is for notification
                      // Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3239/3239952.png',),
                      //   height: 20,width: 20,),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Setting()));
                        },
                        child: Image(
                          image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/128/2040/2040504.png',
                          ),
                          height: 20,
                          width: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Stack(children: [
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepPurple[200],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 7,
                          left: 4,
                          child: Image(
                            image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/128/6423/6423882.png',
                            ),
                            height: 15,
                            width: 15,
                          ),
                        ),
                        Positioned(
                            top: 7,
                            right: 9,
                            child: Text(
                              "Pro",
                              style: TextStyle(fontSize: 10),
                            )),
                      ]),
                      SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 22,
                          ),
                          Text(
                            "Rcently",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: SizedBox(
                          height: 100,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc('${FirebaseAuth.instance.currentUser?.uid ?? 'default_uid'}')
                                .collection('images')
                                .orderBy('uploadTime', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final List<Widget> imageWidgets = [];
                                final docs = snapshot.data!.docs;

                                // If there are no images uploaded by the user in Firestore, display default local images
                                if (docs.isEmpty) {
                                  // Add local images to the list
                                  for (var index = 0; index < products.length; index++) {
                                    imageWidgets.add(
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: 80,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              '${products[index]['image_path']}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  // If there are images uploaded by the user in Firestore, display them
                                  for (var doc in docs) {
                                    final data = doc.data() as Map<String, dynamic>;
                                    final imageURL = data['imageUrl'] as String?;
                                    if (imageURL != null) {
                                      imageWidgets.add(
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 60,
                                                          bottom: 40,
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.7,
                                                          height: MediaQuery.of(context).size.width * 0.7,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(imageURL),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 10,
                                                        right: 10,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // showDialog(
                                                                //   context: context,
                                                                //   builder: (BuildContext context) {
                                                                //     return AlertDialog(
                                                                //       title: Text("Confirm Delete"),
                                                                //       content: Text("Are you sure you want to delete this photo?"),
                                                                //       actions: [
                                                                //         TextButton(
                                                                //           onPressed: () {
                                                                //             Navigator.of(context).pop();
                                                                //           },
                                                                //           child: Text("Cancel"),
                                                                //         ),
                                                                //         TextButton(
                                                                //           onPressed: () async {
                                                                //             // Perform delete operation
                                                                //             try {
                                                                //               await FirebaseFirestore.instance
                                                                //                   .collection('users')
                                                                //                   .doc('${FirebaseAuth.instance.currentUser?.uid ?? 'default_uid'}')
                                                                //                   .collection('images')
                                                                //                   .doc(doc.id) // Use doc.id to get the document ID
                                                                //                   .delete();
                                                                //
                                                                //               Navigator.of(context).pop();
                                                                //               Navigator.of(context, rootNavigator: true).pop();
                                                                //             } catch (e) {
                                                                //               print("Error deleting photo: $e");
                                                                //             }
                                                                //           },
                                                                //           child: Text("Delete"),
                                                                //         ),
                                                                //       ],
                                                                //     );
                                                                //   },
                                                                // );
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                child: Image.asset(
                                                                  'assets/images/img_17.png',
                                                                  height: 27,
                                                                  width: 27,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 12,
                                                        right: 50,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _downloadImage(imageURL);
                                                              },
                                                              child: Container(
                                                                child: Image.asset(
                                                                  'assets/images/img_10.png',
                                                                  height: 26,
                                                                  width: 26,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 80,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  imageURL,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }

                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: imageWidgets,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // albums
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Albums",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .91,
                          decoration: BoxDecoration(
                            // Replace the gradient with Image.network
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/image/img_7.png',
                              ),
                              fit: BoxFit
                                  .cover, // Adjust this based on your needs
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 23,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Animals",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "50+ photos",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //all photos
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ImagePicker1(source: ImageSource.gallery).pick(
                                      onPick: (File? image) {
                                        if (image != null) {
                                          appImageProvider.changeImageFile(image);
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context)=>HomeScreen()));
                                        }
                                      },
                                    );
                                  },

                                  // onTap: () async {
                                  //   final pickedImage = await ImagePicker()
                                  //       .pickImage(source: ImageSource.gallery);
                                  //   if (pickedImage != null) {
                                  //     File imageFile = File(pickedImage.path);
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 FilterScreen(
                                  //                   imageFile: imageFile,
                                  //                 )));
                                  //   }
                                  // },
                                  // onTap: (){
                                  //   all = true;
                                  //   jackets = false;
                                  //   shoes = false;
                                  //   setState(() {
                                  //
                                  //   });
                                  // },
                                  // onTap: () {
                                  //   ImagePicker1(source: ImageSource.gallery).pick(
                                  //     onPick: (File? image) {
                                  //       if (image != null) {
                                  //         appImageProvider.changeImageFile(image);
                                  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                  //       }
                                  //     },
                                  //   );
                                  // },
                                  child:
                                  // Material(
                                  //    elevation: 3.0,
                                  //   borderRadius: BorderRadius.circular(10),
                                  //  // color: all? Colors.deepPurple[200] : Colors.white,
                                  //   //  color: selectedCategoryProvider.selectedCategory == index
                                  //   //      ? Colors.white
                                  //   //      : Colors.white.withOpacity(0.4),
                                  //   child: Container(
                                  //     height: 55,
                                  //     width: 55,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       color: Colors.deepPurple[100],
                                  //     ),
                                  //     child:
                                  //     // Padding(
                                  //     //   padding: const EdgeInsets.all(8.0),
                                  //     //   child:
                                  //     //   Icon(Icons.border_all_outlined),
                                  //     // ),
                                  //     Image.asset('assets/images/img_8.png',height: 5,width: 5,),
                                  //   ),
                                  // ),
                                  Material(
                                    elevation: 3.0,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple[100],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          'assets/image/img_9.png',
                                          height:
                                          5, // Adjust the height as needed
                                          width:
                                          5, // Adjust the width as needed
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "All photos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ImagePicker1(source: ImageSource.camera).pick(
                                      onPick: (File? image) {
                                        if (image != null) {
                                          appImageProvider.changeImageFile(image);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                        }
                                      },
                                    );
                                  },
                                  // onTap: (){
                                  //   all = true;
                                  //   jackets = false;
                                  //   shoes = false;
                                  //   setState(() {
                                  //
                                  //   });
                                  // },
                                  child:
                                  Material(
                                    elevation: 3.0,
                                    borderRadius: BorderRadius.circular(10),
                                    // color: all? Colors.deepPurple[200] : Colors.white,
                                    //  color: selectedCategoryProvider.selectedCategory == index
                                    //      ? Colors.white
                                    //      : Colors.white.withOpacity(0.4),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple[100],
                                      ),
                                      child: Material(
                                        elevation: 3.0,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.deepPurple[100],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/image/img_8.png',
                                              height:
                                              5, // Adjust the height as needed
                                              width:
                                              5, // Adjust the width as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child:
                                      //   Icon(Icons.camera_alt),
                                      // ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  // onTap: (){
                                  //   all = true;
                                  //   jackets = false;
                                  //   shoes = false;
                                  //   setState(() {
                                  //
                                  //   });
                                  // },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Download()));
                                  },
                                  child: Material(
                                    elevation: 3.0,
                                    borderRadius: BorderRadius.circular(10),
                                    // color: all? Colors.deepPurple[200] : Colors.white,
                                    //  color: selectedCategoryProvider.selectedCategory == index
                                    //      ? Colors.white
                                    //      : Colors.white.withOpacity(0.4),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple[100],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          'assets/image/img_10.png',
                                          height:
                                          5, // Adjust the height as needed
                                          width:
                                          5, // Adjust the width as needed
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child:
                                      //   Icon(Icons.download_for_offline),
                                      // ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Downloads",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondHome()));
                                  },
                                  // onTap: (){
                                  //   all = true;
                                  //   jackets = false;
                                  //   shoes = false;
                                  //   setState(() {
                                  //
                                  //   });
                                  // },
                                  child: Material(
                                    elevation: 3.0,
                                    borderRadius: BorderRadius.circular(10),
                                    // color: all? Colors.deepPurple[200] : Colors.white,
                                    //  color: selectedCategoryProvider.selectedCategory == index
                                    //      ? Colors.white
                                    //      : Colors.white.withOpacity(0.4),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple[100],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Image.asset(
                                          'assets/image/img_11.png',
                                          height:
                                          5, // Adjust the height as needed
                                          width:
                                          5, // Adjust the width as needed
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Others",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //november
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "March , 2024",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: SizedBox(
                          height: 100,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc('${FirebaseAuth.instance.currentUser?.uid ?? 'default_uid'}')
                                .collection('images')
                                .orderBy('uploadTime', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final List<Widget> imageWidgets = [];
                                final docs = snapshot.data!.docs;

                                // Filter documents based on the month of March (month number 3)
                                final filteredDocs = docs.where((doc) {
                                  final data = doc.data() as Map<String, dynamic>;
                                  final uploadTime = DateTime.parse(data['uploadTime']);
                                  return uploadTime.month == 3; // March
                                }).toList();

                                // If there are no images uploaded by the user for March, display default local images
                                if (filteredDocs.isEmpty) {
                                  for (var index = 0; index < products.length; index++) {
                                    imageWidgets.add(
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: 80,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              '${products[index]['image_path']}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  // Display images uploaded by the user for March
                                  for (var doc in filteredDocs) {
                                    final data = doc.data() as Map<String, dynamic>;
                                    final imageURL = data['imageUrl'] as String?;
                                    if (imageURL != null) {
                                      imageWidgets.add(
                                        GestureDetector(
                                          onTap: () {
                                            // Show dialog to view image
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 60,
                                                          bottom: 40,
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.7,
                                                          height: MediaQuery.of(context).size.width * 0.7,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(imageURL),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 10,
                                                        right: 10,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // Show delete confirmation dialog
                                                                // showDialog(
                                                                //   context: context,
                                                                //   builder: (BuildContext context) {
                                                                //     return AlertDialog(
                                                                //       title: Text("Confirm Delete"),
                                                                //       content: Text("Are you sure you want to delete this photo?"),
                                                                //       actions: [
                                                                //         TextButton(
                                                                //           onPressed: () {
                                                                //             Navigator.of(context).pop();
                                                                //           },
                                                                //           child: Text("Cancel"),
                                                                //         ),
                                                                //         TextButton(
                                                                //           onPressed: () async {
                                                                //             // Perform delete operation
                                                                //             try {
                                                                //               await FirebaseFirestore.instance
                                                                //                   .collection('users')
                                                                //                   .doc('${FirebaseAuth.instance.currentUser?.uid ?? 'default_uid'}')
                                                                //                   .collection('images')
                                                                //                   .doc(doc.id) // Use doc.id to get the document ID
                                                                //                   .delete();
                                                                //
                                                                //               Navigator.of(context).pop();
                                                                //               Navigator.of(context, rootNavigator: true).pop();
                                                                //             } catch (e) {
                                                                //               print("Error deleting photo: $e");
                                                                //             }
                                                                //           },
                                                                //           child: Text("Delete"),
                                                                //         ),
                                                                //       ],
                                                                //     );
                                                                //   },
                                                                // );
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                child: Image.asset(
                                                                  'assets/image/img_17.png',
                                                                  height: 27,
                                                                  width: 27,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 12,
                                                        right: 50,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _downloadImage(imageURL);
                                                              },
                                                              child: Container(
                                                                child: Image.asset(
                                                                  'assets/image/img_10.png',
                                                                  height: 26,
                                                                  width: 26,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 80,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  imageURL,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }

                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: imageWidgets,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StartScreen()));
                        },
                        child: Text("filter"),
                      ),

                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageFilterPage(),));
                        },
                        child: Text("filter"),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}