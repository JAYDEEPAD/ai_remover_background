import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: SecondHome()));
}

class SecondHome extends StatefulWidget {
  const SecondHome({Key? key}) : super(key: key);

  @override
  State<SecondHome> createState() => _SecondHomeState();
}

class _SecondHomeState extends State<SecondHome> {
  String? imageUrl;
  bool isProcessing = false;
  String? errorMessage;
  String? newimageUrl;

  // Method to call the API for removing background
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
              if(newimageUrl!=null)
                SizedBox(height: 200,width: 200,
                  child: Image.network(
                    '$newimageUrl',
                    fit: BoxFit.cover,
                    scale: 1,
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    imageUrl =
                    "https://4.img-dpreview.com/files/p/TS600x600~sample_galleries/3002635523/4971879462.jpg";
                  });
                  print(imageUrl);
                },
                child: Text(
                  "Upload Image",
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
                removeBackground();
              },
              // Button text changes based on processing state
              child: isProcessing
                  ? CircularProgressIndicator()
                  : Text("Remove Background"),
            ),
            ),
        );}
}
