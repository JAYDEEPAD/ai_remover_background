

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:projects/widgets/provider.dart';
// import 'package:provider/provider.dart';
//
// class Const_value {
//   String cdn_url_image_display = "https://cdn.dohost.in//upload//";
//   String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
// }
//
// class Background_Remove extends StatefulWidget {
//   const Background_Remove({Key? key}) : super(key: key);
//
//   @override
//   State<Background_Remove> createState() => _Background_RemoveState();
// }
//
// class _Background_RemoveState extends State<Background_Remove> {
//   late AppImageProvider appImageProvider;
//   bool isProcessing = false;
//   String? _uploadedImageUrl;
//   String? newimageUrl;
//   String? errorMessage;
//   bool _isUploading = false;
//   File? _selectedImage;
//   File? _currentImage;
//
//   // Future<void> uploadToCDNAndRemoveBackground() async {
//   //   String url = Const_value().cdn_url_upload;
//   //
//   //   var request = http.MultipartRequest('POST', Uri.parse(url));
//   //
//   //   if (appImageProvider.currentImage != null) {
//   //     request.files.add(
//   //       await http.MultipartFile.fromPath('b_video', appImageProvider.currentImage!.path),
//   //     );
//   //   }
//   //
//   //
//   //   try {
//   //     var response = await request.send();
//   //     if (response.statusCode == 200) {
//   //       var responseData = await response.stream.toBytes();
//   //       var responseString = utf8.decode(responseData);
//   //       var jsonResponse = json.decode(responseString);
//   //       String imageUrl = jsonResponse['image_url'] ?? '';
//   //       setState(() {
//   //         _uploadedImageUrl = imageUrl;
//   //       });
//   //       removeBackground(); // Call the background removal function
//   //     } else {
//   //       // Handle error if response status code is not 200
//   //     }
//   //   } finally {
//   //     setState(() {
//   //       isProcessing = false;
//   //     });
//   //   }
//   // }
//   // Future<void> uploadToCDN() async {
//   //   print("object");
//   //   String url = Const_value().cdn_url_upload;
//   //   try {
//   //     final base64Image = base64Encode(appImageProvider.currentImage);
//   //
//   //     final response = await http.post(
//   //       Uri.parse(url),
//   //       body: {
//   //         'image': base64Image,
//   //       },
//   //     );
//   //     print(base64Image);
//   //     if (response.statusCode == 200) {
//   //       final responseData = jsonDecode(response.body);
//   //       String imageUrl = responseData['image_url'] ?? '';
//   //       print(imageUrl);
//   //
//   //       setState(() {
//   //         _uploadedImageUrl = imageUrl;
//   //       });
//   //       print(_uploadedImageUrl);
//   //     } else {
//   //       setState(() {
//   //         errorMessage = 'Failed to upload image: ${response.statusCode}';
//   //       });
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       errorMessage = 'Failed to upload image: $e';
//   //     });
//   //   } finally {
//   //     setState(() {
//   //       isProcessing = false;
//   //     });
//   //   }
//   // }
//   //
//   // // Future<void> removeBackground() async {
//   // //   final apiUrl = 'https://bgremove.dohost.in/remove-bg';
//   // //   print(apiUrl);
//   // //   try {
//   // //     // Sending a POST request to the API with image URL
//   // //     final response = await http.post(
//   // //       Uri.parse(apiUrl),
//   // //       headers: {
//   // //         'Content-Type': 'application/json',
//   // //       },
//   // //       body: jsonEncode({
//   // //         "image_url": _uploadedImageUrl,
//   // //       }),
//   // //     );
//   // //       print(_uploadedImageUrl);
//   // //     print(response.body);
//   // //     if (response.statusCode == 200) {
//   // //       final responseData = jsonDecode(response.body);
//   // //       final imageData = responseData['image_url'];
//   // //       print(imageData);
//   // //       setState(() {
//   // //         newimageUrl = imageData;
//   // //       });
//   // //     } else {
//   // //       setState(() {
//   // //         errorMessage = 'Failed to remove background: ${response.statusCode}';
//   // //       });
//   // //     }
//   // //   } catch (e) {
//   // //     setState(() {
//   // //       errorMessage = 'Failed to remove background: $e';
//   // //     });
//   // //   } finally {
//   // //     setState(() {
//   // //       isProcessing = false;
//   // //     });
//   // //   }
//   // // }
//   Future<void> removeBackground() async {
//
//     final apiUrl = 'https://bgremove.dohost.in/remove-bg';
//     print(apiUrl);
//     try {
//       if (_uploadedImageUrl == null) {
//         setState(() {
//           errorMessage = 'Uploaded image URL is null';
//         });
//         return;
//       }
//       // Sending a POST request to the API with image URL
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "image_url": _uploadedImageUrl,
//         }),
//       );
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         if (responseData.containsKey('image_url')) {
//           final imageData = responseData['image_url'];
//           print('Background removed. New image URL: $imageData');
//           setState(() {
//             newimageUrl = imageData;
//           });
//         } else {
//           setState(() {
//             errorMessage = 'Image URL not found in the response';
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = 'Failed to remove background: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to remove background: $e';
//       });
//     } finally {
//       setState(() {
//         isProcessing = false;
//       });
//     }
//   }
//   Future<void> uploadToCDNAndRemoveBackground() async {
//     print("object");
//     String url = Const_value().cdn_url_upload;
//     try {
//       final base64Image = base64Encode(appImageProvider.currentImage);
//
//       final response = await http.post(
//         Uri.parse(url),
//
//         body: {
//           'image': base64Image,
//         },
//
//       );
//       print(url);
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         String imageUrl = responseData['image_url'] ?? '';
//         print(imageUrl);
//         print(imageUrl);
//         setState(() {
//           _uploadedImageUrl = imageUrl;
//         });
//
//         print(_uploadedImageUrl);
//         print("hello");
//
//         // After successful upload to CDN, call removeBackground
//         await removeBackground();
//       } else {
//         setState(() {
//           errorMessage = 'Failed to upload image: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to upload image: $e';
//       });
//     } finally {
//       setState(() {
//         isProcessing = false;
//       });
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Background Remove'),
//       ),
//       body:
//          Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // Display the image (either original or with background removed)
//                 newimageUrl != null
//                     ? SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Image.network(
//                     newimageUrl!, // Display the image with the background removed
//                     fit: BoxFit.cover,
//                     scale: 1,
//                   ),
//                 )
//                     : Consumer<AppImageProvider>(
//                   builder: (context, appImageProvider, _) {
//                     if (appImageProvider.currentImage != null) {
//                       return FutureBuilder<File>(
//                         future: appImageProvider.convertImageToFile(appImageProvider.currentImage!),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.done) {
//                             return Image.file(
//                               snapshot.data!,
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             );
//                           } else {
//                             return CircularProgressIndicator();
//                           }
//                         },
//                       );
//                     } else {
//                       return Text('No Image Selected');
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                 onPressed: () {
//                   uploadToCDNAndRemoveBackground();
//                 },
//                 child: Text('Remove Background'),
//                 ),
//                 // Button to upload the image
//               ],
//             ),
//           ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:projects/widgets/provider.dart';
// import 'package:provider/provider.dart';
//
// class NewApiScreen extends StatefulWidget {
//   const NewApiScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NewApiScreen> createState() => _NewApiScreenState();
// }
//
// class _NewApiScreenState extends State<NewApiScreen> {
//   bool _isUploading = false;
//   String? _uploadedImageUrl;
//   String? newimageUrl;
//   String? errorMessage;
//   bool isProcessing = false;
//   late AppImageProvider appImageProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   }
//   Future<File> _createTempFile(Uint8List imageData) async {
//     final tempDir = await getTemporaryDirectory();
//     final tempPath = tempDir.path;
//     final tempFile = File('$tempPath/temp_image.jpg');
//     await tempFile.writeAsBytes(imageData);
//     return tempFile;
//   }
//   Future<void> _uploadImage() async {
//     setState(() {
//       _isUploading = true;
//     });
//
//     // Get the current image from the provider
//     final currentImage = appImageProvider.currentImage;
//
//     if (currentImage == null) {
//       // Handle if no image was selected
//       setState(() {
//         _isUploading = false;
//       });
//       return;
//     }
//
//     String url = Const_value().cdn_url_upload;
//
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//
//     // Add the current image to the request
//     request.files.add(
//       http.MultipartFile.fromBytes('b_video', currentImage, filename: 'image.jpg'),
//     );
//
//     try {
//       var response = await request.send();
//       print(response);
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.toBytes();
//         print(responseData);
//         var responseString = utf8.decode(responseData);
//         var jsonResponse = json.decode(responseString);
//         print(jsonResponse);
//         String imagePath = jsonResponse['iamge_path'] ?? '';
//         print(imagePath);
//         setState(() {
//           _uploadedImageUrl = imagePath;
//         });
//         print(_uploadedImageUrl);
//       } else {
//         // Handle error if response status code is not 200
//       }
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
//   Future<void> removeBackground() async {
//     final apiUrl = 'https://bgremove.dohost.in/remove-bg';
//     try {
//       // Sending a POST request to the API with image URL
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "image_url": _uploadedImageUrl,
//         }),
//       );
//
//       print(response.body);
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         final imageData = responseData['image_url'];
//         print(imageData);
//         setState(() {
//           newimageUrl = imageData;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to remove background: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to remove background: $e';
//       });
//     } finally {
//       setState(() {
//         isProcessing = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display the current image from the provider
//             Consumer<AppImageProvider>(
//               builder: (context, appImageProvider, _) {
//                 final currentImage = appImageProvider.currentImage;
//                 if (currentImage != null) {
//                   return FutureBuilder<File>(
//                     future: _createTempFile(currentImage),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (snapshot.hasData) {
//                         return Image.file(
//                           snapshot.data!,
//                           height: 200, // Adjust the height as needed
//                         );
//                       } else {
//                         return Text('No Image Selected'); // Show a message if no image is selected
//                       }
//                     },
//                   );
//                 } else {
//                   return Text('No Image Selected'); // Show a message if no image is selected
//                 }
//               },
//             ),
//
//             SizedBox(height: 20),
//             // Button to remove background
//             ElevatedButton(
//               onPressed: _isUploading ? null : removeBackground,
//               child: _isUploading
//                   ? CircularProgressIndicator()
//                   : Text('Remove Background'),
//             ),
//             // Display error message if background removal fails
//             errorMessage != null ? Text(errorMessage!) : Container(),
//           ],
//         ),
//       ),
//     );
//   }
//   //
//   // Future<void> _uploadToCDNAndRemoveBackground() async {
//   //   setState(() {
//   //     _isUploading = true;
//   //   });
//   //
//   //   try {
//   //     // Set _currentImage with the image data from the provider
//   //     final currentImage = appImageProvider.currentImage;
//   //     if (currentImage == null) {
//   //       throw 'No image selected';
//   //     }
//   //     print(currentImage);
//   //     final file = File.fromRawPath(currentImage);
//   //     // Upload image to CDN
//   //     String imageUrl = await uploadToCDN(file);
//   //
//   //     // Remove background after successful upload
//   //     if (imageUrl.isNotEmpty) {
//   //       await removeBackground(imageUrl);
//   //     } else {
//   //       setState(() {
//   //         errorMessage = 'Failed to upload image to CDN';
//   //       });
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       errorMessage = 'Error: $e';
//   //     });
//   //   } finally {
//   //     setState(() {
//   //       _isUploading = false;
//   //     });
//   //   }
//   // }
//   //
//   // Future<String> uploadToCDN(File image) async {
//   //   String url = Const_value().cdn_url_upload;
//   //
//   //   var request = http.MultipartRequest('POST', Uri.parse(url));
//   //   request.files.add(
//   //     await http.MultipartFile.fromPath('b_video', image.path),
//   //   );
//   //
//   //   var response = await request.send();
//   //   if (response.statusCode == 200) {
//   //     var responseData = await response.stream.toBytes();
//   //     var responseString = utf8.decode(responseData);
//   //     var jsonResponse = json.decode(responseString);
//   //     String imageUrl = jsonResponse['iamge_path'] ?? '';
//   //     return imageUrl;
//   //   } else {
//   //     throw 'Failed to upload image: ${response.statusCode}';
//   //   }
//   // }
//   //
//   // Future<void> removeBackground(String imageUrl) async {
//   //   final apiUrl = 'https://bgremove.dohost.in/remove-bg';
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //       },
//   //       body: jsonEncode({
//   //         "image_url": imageUrl,
//   //       }),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final responseData = jsonDecode(response.body);
//   //       final imageData = responseData['image_url'];
//   //       setState(() {
//   //         newimageUrl = imageData;
//   //       });
//   //     } else {
//   //       throw 'Failed to remove background: ${response.statusCode}';
//   //     }
//   //   } catch (e) {
//   //     throw 'Failed to remove background: $e';
//   //   }
//   // }
// }
//
// class Const_value {
//   String cdn_url_image_display = "https://cdn.dohost.in//upload//";
//   String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
// }





//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// class NewApiScreen extends StatefulWidget {
//   const NewApiScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NewApiScreen> createState() => _NewApiScreenState();
// }
//
// class _NewApiScreenState extends State<NewApiScreen> {
//   bool _isUploading = false;
//   File? _selectedImage;
//   String? _uploadedImageUrl;
//   String? newimageUrl;
//   String? errorMessage;
//   bool isProcessing = false;
//   File? _currentImage;
//
//   Future<void> _uploadImage() async {
//     setState(() {
//       _isUploading = true;
//     });
//
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//     }
//
//     if (_selectedImage == null) {
//       // Handle if no image was selected
//       setState(() {
//         _isUploading = false;
//       });
//       return;
//     }
//
//     String url = Const_value().cdn_url_upload;
//     print(url);
//
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     print(request);
//     if (_selectedImage != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath('b_video', _selectedImage!.path),
//       );
//     }
//
//     try {
//       var response = await request.send();
//       print(response);
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.toBytes();
//         print(responseData);
//         var responseString = utf8.decode(responseData);
//         var jsonResponse = json.decode(responseString);
//         print(jsonResponse);
//         String imagePath = jsonResponse['iamge_path'] ?? '';
//         print(imagePath);
//         setState(() {
//           _uploadedImageUrl = imagePath;
//         });
//         print(_uploadedImageUrl);
//       } else {
//         // Handle error if response status code is not 200
//       }
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
//   Future<void> removeBackground() async {
//     final apiUrl = 'https://bgremove.dohost.in/remove-bg';
//     try {
//       // Sending a POST request to the API with image URL
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "image_url": _uploadedImageUrl,
//         }),
//       );
//
//       print(response.body);
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         final imageData = responseData['image_url'];
//         print(imageData);
//         setState(() {
//           newimageUrl = imageData;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to remove background: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to remove background: $e';
//       });
//     } finally {
//       setState(() {
//         isProcessing = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display the image (either original or with background removed)
//             newimageUrl != null
//                 ? SizedBox(
//               height: 200,
//               width: 200,
//               child: Image.network(
//                 newimageUrl!, // Display the image with the background removed
//                 fit: BoxFit.cover,
//                 scale: 1,
//               ),
//             )
//                 : (_selectedImage != null
//                 ? Image.file(
//               _selectedImage!,
//               height: 200,
//             )
//                 : Text('No Image Selected')),
//             SizedBox(height: 20),
//             // Button to upload the image
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadImage,
//               child: _isUploading
//                   ? CircularProgressIndicator()
//                   : Text('Upload Image'),
//             ),
//           ],
//         ),
//
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 56,
//         child: ElevatedButton(
//           onPressed: () {
//             removeBackground();
//           },
//           // Button text changes based on processing state
//           child: isProcessing
//               ? CircularProgressIndicator()
//               : Text("Remove Background"),
//         ),
//       ),
//     );
//   }
// }
//
// class Const_value {
//   String cdn_url_image_display = "https://cdn.dohost.in//upload//";
//   String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewApiScreen extends StatefulWidget {
  const NewApiScreen({Key? key}) : super(key: key);

  @override
  State<NewApiScreen> createState() => _NewApiScreenState();
}

class _NewApiScreenState extends State<NewApiScreen> {
  bool _isUploading = false;
  File? _selectedImage;
  String? _uploadedImageUrl;
  String? newimageUrl;
  String? errorMessage;
  bool isProcessing = false;
  File? _currentImage;

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }

    if (_selectedImage == null) {
      // Handle if no image was selected
      setState(() {
        _isUploading = false;
      });
      return;
    }

    String url = Const_value().cdn_url_upload;
    print(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(request);
    if (_selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('b_video', _selectedImage!.path),
      );
    }

    try {
      var response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        print(responseData);
        var responseString = utf8.decode(responseData);
        var jsonResponse = json.decode(responseString);
        print(jsonResponse);
        String imagePath = jsonResponse['iamge_path'] ?? '';
        print(imagePath);
        setState(() {
          _uploadedImageUrl = imagePath;
        });
        print(_uploadedImageUrl);
      } else {
        // Handle error if response status code is not 200
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
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
          "image_url": _uploadedImageUrl,
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
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the image (either original or with background removed)
            newimageUrl != null
                ? SizedBox(
              height: 200,
              width: 200,
              child: Image.network(
                newimageUrl!, // Display the image with the background removed
                fit: BoxFit.cover,
                scale: 1,
              ),
            )
                : (_selectedImage != null
                ? Image.file(
              _selectedImage!,
              height: 200,
            )
                : Text('No Image Selected')),
            SizedBox(height: 20),
            // Button to upload the image
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Upload Image'),
            ),
          ],
        ),

      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            removeBackground();
          },
          // Button text changes based on processing state
          child: isProcessing
              ? CircularProgressIndicator()
              : Text("Remove Background"),
        ),
      ),
    );
  }
}

class Const_value {
  String cdn_url_image_display = "https://cdn.dohost.in//upload//";
  String cdn_url_upload = "https://cdn.dohost.in/image_upload.php/";
}