import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_remover_background/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NewApiScreen extends StatefulWidget {
  const NewApiScreen({Key? key}) : super(key: key);

  @override
  State<NewApiScreen> createState() => _NewApiScreenState();
}

class _NewApiScreenState extends State<NewApiScreen> {
  bool _isUploading = false;
  File? _selectedImage;
  String? _currentImage;
  String? _base64Image;
  String? newimageUrl;
  String? errorMessage;
  bool isProcessing = false;
  String? _uploadedImageUrl;
  //String base64String = '';
  String? downloadUrl;

  late AppImageProvider appImageProvider;

  @override
  void initState() {
    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    // Access _currentImage directly from the provider
    Uint8List? currentImage = Provider
        .of<AppImageProvider>(context, listen: false)
        .currentImage;

    if (currentImage == null) {
      // Handle if no image is available
      setState(() {
        _isUploading = false;
      });
      return;
    }

    String url = Const_value().cdn_url_upload;
    print(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(request);
    request.files.add(
      http.MultipartFile.fromBytes('b_video', currentImage,
          filename: 'image.jpg'), // Provide a filename for the uploaded image
    );

    try {
      var response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        print(responseData);
        var responseString = utf8.decode(responseData);
        var jsonResponse = json.decode(responseString);
        print(jsonResponse);
        String imagePath = jsonResponse['image_path'] ?? '';
        print(imagePath);
        setState(() {
         _uploadedImageUrl = imagePath;
        });
        print(_uploadedImageUrl);
        // Call removeBackground() with the uploaded image data
        await removeBackground();
      } else {
        // Handle error if response status code is not 200
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Future<void> removeBackground(Uint8List imageData) async {
  //   final apiUrl = 'https://bgremove.dohost.in/remove-bg';
  //   try {
  //     // Sending a POST request to the API with image bytes
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         "image_bytes": base64Encode(imageData), // Convert image bytes to base64
  //       }),
  //     );
  //
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       final imageData = responseData['image_url'];
  //       print(imageData);
  //       setState(() {
  //         newimageUrl = imageData;
  //       });
  //     } else {
  //       setState(() {
  //         errorMessage = 'Failed to remove background: ${response.statusCode}';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = 'Failed to remove background: $e';
  //     });
  //   } finally {
  //     setState(() {
  //       isProcessing = false;
  //     });
  //   }
  // }
  Future<void> removeBackground() async {
    final apiUrl = 'https://bgremove.dohost.in/remove-bg';
    try {
      // Sending a POST request to the API with image URL
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "image_url": _uploadedImageUrl, // Use the uploaded image URL directly
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
      appBar: AppBar(
        title: Text('Image Remove Example'),
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (newimageUrl != null) {
              // Display the background-removed image if available
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      newimageUrl!,
                      // Assuming newimageUrl contains the URL of the background-removed image
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            } else if (value.currentImage != null) {
              // Display the original image if background-removed image is not available yet
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.memory(
                      value.currentImage!,
                      // Assuming currentImage is already Uint8List
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            }
            // Display a loading indicator if no image is available yet
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<AppImageProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                // Convert the image data to a base64 string
                String imageDataString = base64Encode(value.currentImage!);
                print(imageDataString);

                // Upload the image to Firebase Storage
                String? downloadUrl = await uploadBase64ImageToFirebase(imageDataString);
                print(downloadUrl);
                // Display a message based on the upload result
                if (downloadUrl != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Image uploaded successfully to Firebase Storage'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error uploading image to Firebase Storage'),
                  ));
                }
              },
              child: Text('Remove Background'),
            ),
          );
        },
      ),
    );
  }



  Future<String?> uploadBase64ImageToFirebase(String base64String) async {
    try {
      // Convert base64 string to bytes
      Uint8List bytes = base64.decode(base64String);

      // Generate a random filename or use your own logic
      String fileName = 'image_${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg';

      // Get reference to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      // Upload bytes to Firebase Storage
      TaskSnapshot uploadTask = await storageRef.putData(bytes);

      // Get the download URL of the uploaded file
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      print(downloadUrl);
      // Return the download URL
      return downloadUrl;
    } catch (e) {
      // Handle errors
      print("Error uploading image to Firebase Storage: $e");
      return null;
    }
  }
}

class Const_value {
  String cdn_url_image_display = "https://cdn.dohost.in//upload//";
  String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
}




