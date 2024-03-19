import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: RemoveScreen()));
}

class RemoveScreen extends StatefulWidget {
  const RemoveScreen({Key? key}) : super(key: key);

  @override
  State<RemoveScreen> createState() => _RemoveScreenState();
}

class _RemoveScreenState extends State<RemoveScreen> {
  String? imageUrl;
  bool isProcessing = false;
  String? errorMessage;
  String? newimageUrl;

  final ImagePicker _picker = ImagePicker();

    Future<void> removeBackground(String imagePath) async {
    final apiUrl = 'https://bgremove.dohost.in/remove-bg';

    try {
      // Sending a POST request to the API with image URL
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "image_url": imageUrl,
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


  // Method to pick an image from the gallery
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageUrl = pickedFile.path;
      } else {
        errorMessage = 'No image selected.';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("AI Background Remover"),
      ),
      body: Center(
        child: Column(
          children: [
            if (imageUrl != null)
              SizedBox(
                height: 200,
                width: 200,
                child: Image.file(
                  File(imageUrl!),
                  fit: BoxFit.cover,
                  scale: 1,
                ),
              ),
            if (newimageUrl != null)
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                  '$newimageUrl',
                  fit: BoxFit.cover,
                  scale: 1,
                ),
              ),
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: Text(
                "Select Image from Gallery",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: Text(
                "Capture Image from Camera",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            if (imageUrl != null) {
              removeBackground(imageUrl!);
            } else {
              setState(() {
                errorMessage = 'No image selected.';
              });
            }
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

