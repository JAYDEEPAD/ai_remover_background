import 'dart:io';
import 'dart:typed_data';
import 'package:ai_remover_background/model.dart';
import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loaded = false;
  bool removedbg = false;
  bool isLoading = false;

  Uint8List? imageBytes;
  String imagePath = '';

  Future<void> pickImage() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (img != null) {
      imagePath = img.path;
      loaded = true;
      setState(() {});
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
        child: removedbg
            ? BeforeAfter(
          before: Image.file(File(imagePath)),
          after: Image.memory(imageBytes!),
        )
            : loaded
            ? GestureDetector(
          onTap: pickImage,
          child: Image.file(File(imagePath)),
        )
            : SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: pickImage,
            child: const Text("Remove Background"),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: loaded
              ? () async {
            setState(() {
              isLoading = true;
            });

            // Check if imagePath is not empty
            if (imagePath.isNotEmpty) {
              final request = RemoveBackgroundRequest(imagePath);
              imageBytes = await Api.removeBackground(request);
              if (imageBytes != null) {
                removedbg = true;
              }
            } else {
              print('Image path is empty');
            }
            setState(() {
              isLoading = false;
            });
          }
              : null,
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text("Remove Background"),
        ),
      ),
    );
  }
}
