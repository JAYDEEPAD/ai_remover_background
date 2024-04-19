

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_remover_background/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  String? _currentImage;


  Future<void> _uploadImage() async {
    /*setState(() {
      _isUploading = true;
    });
*/
    /*final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
*/
    /*if (_selectedImage == null) {
      // Handle if no image was selected
      setState(() {
        _isUploading = false;
      });
      return;
    }
*/
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
          _currentImage = imagePath;
        });
        print(_currentImage);
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
          "image_url": _currentImage,
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
      body:Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              print(value.currentImage);
              // Convert the current image to base64
              String base64Image = base64Encode(value.currentImage!);

              // Print the base64 string
              print('Base64 Image: $base64Image');

              // Decode the base64 string to Uint8List
              Uint8List bytes = base64Decode(base64Image);
              print(bytes);

              // Display the image
              return Image.memory(bytes);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      /*Center(
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
            *//*ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Upload Image'),
            ),*//*
          ],
        ),

      ),*/
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