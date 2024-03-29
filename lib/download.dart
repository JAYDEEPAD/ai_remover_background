import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        centerTitle: true,
        title: Text('Download Page',style: TextStyle(


        ),),
      ),
      body:
      /*Padding(
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
              } else if (snapshot.data!.docs.isEmpty) {
                // If there are no images uploaded by the user, display default local images
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                    );
                  },
                );
              } else {
                // If there are images uploaded by the user, display them
                final List<Widget> imageWidgets = [];
                final docs = snapshot.data!.docs;
                for (var doc in docs) {
                  final data = doc.data() as Map<String, dynamic>;
                  final imageURL = data['imageURL'] as String?;
                  final uploadTime = DateTime.parse(data['uploadTime']);
                  print(imageURL);
                  print(uploadTime);
                  if (imageURL != null) { // Check if imageURL is not null
                    imageWidgets.add(
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
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
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: imageWidgets,
                );
              }
            },
          ),
        ),
      ),*/
      Padding(
        padding: const EdgeInsets.only(left: 13, right: 13,top: 13),
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
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No images uploaded'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final imageURL = snapshot.data!.docs[index]['imageURL'];
                  final uploadTime = snapshot.data!.docs[index]['uploadTime'];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return
                            Dialog(
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
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
