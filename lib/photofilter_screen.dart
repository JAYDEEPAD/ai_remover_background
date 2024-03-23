import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/photofilters.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    //,
  ),
);

class PhotoFilter extends StatefulWidget {
  File imageFile;
   PhotoFilter({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<PhotoFilter> createState() => _PhotoFilterState();
}

class _PhotoFilterState extends State<PhotoFilter> {
  String? fileName;
  final picker = ImagePicker();
  File? selectedImage;

  Future<void> getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      fileName = basename(selectedImage!.path);
      var image = img.decodeImage(await selectedImage!.readAsBytes());
      image = img.copyResize(image!, width: 600);
      var imageFile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoFilterSelector(
            title: const Text("Photo Filter Example"),
            image: image!,
            filters: presetFiltersList,
            filename: fileName!,
            loader: const Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imageFile != null && imageFile.containsKey('image_filtered')) {
        setState(() {
          selectedImage = imageFile['image_filtered'];
        });
      }
    }
  }

  Future<void> saveImage(BuildContext context) async {
    if (selectedImage != null) {
      final savedFile = await saveImageToDevice(selectedImage!);
      if (savedFile != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved to Gallery'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save image'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected to save'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<File?> saveImageToDevice(File imageFile) async {
    try {
      final appDir = await getExternalStorageDirectory();
      final savePath = appDir!.path;
      print(savePath);
      final fileName = basename(imageFile.path);
      final File newFile = await imageFile.copy('$savePath/$fileName');
      print(newFile);
      await saveImageToGallery(newFile);
      return newFile;
    } catch (e) {
      print('Error saving image: $e');
      return null;
    }
  }
  Future<void> saveImageToGallery(File file) async {
    try {
      final result = await ImageGallerySaver.saveFile(file.path);
      print('Image saved to gallery: $result');
    } catch (e) {
      print('Error saving image to gallery: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Filter Example'),
        actions: [
          IconButton(
            onPressed: () => saveImage(context),
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: selectedImage == null
              ? const Center(
            child: Text('No image selected.'),
          )
              : Image.file(File(selectedImage!.path)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
