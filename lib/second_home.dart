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

  // Method to call the API for removing background
  Future<void> removeBackground() async {
    setState(() {
      isProcessing = true;
    });

    // API endpoint
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
      // Checking if the response status code is successful (200)
      if (response.statusCode == 200) {
        // Parsing the response JSON
        final responseData = jsonDecode(response.body);
        // Getting the image data from the response
        final imageData = responseData['image_data'];
        // Displaying the image using the image data (assuming it's base64 encoded)
        // Here you can store the image data in a variable or use it directly
        // For now, let's just print the length of the decoded image data
        print(base64Decode(imageData).length);
      } else {
        // Handling the case when the API call fails
        print('Failed to remove background: ${response.statusCode}');
      }
    } catch (e) {
      // Handling any exceptions that occur during the API call
      print('Failed to remove background: $e');
    } finally {
      // Setting isProcessing to false after API call completion
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
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : ElevatedButton(
          onPressed: () {
            setState(() {
              imageUrl =
              "https://4.img-dpreview.com/files/p/TS600x600~sample_galleries/3002635523/4971879462.jpg";
            });
          },
          child: Text(
            "Upload Image",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: imageUrl != null && !isProcessing
              ? removeBackground
              : null,
          // Button text changes based on processing state
          child: isProcessing
              ? CircularProgressIndicator()
              : Text("Remove Background"),
        ),
      ),
    );
  }
}
