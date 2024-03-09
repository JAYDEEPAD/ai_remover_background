import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PickCropImageScreen(),
  ));
}

class PickCropImageScreen extends StatefulWidget {
  const PickCropImageScreen({Key? key}) : super(key: key);

  @override
  State<PickCropImageScreen> createState() => _PickCropImageScreenState();
}

class _PickCropImageScreenState extends State<PickCropImageScreen> {
  File? imageFile;

  Future _pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future _cropImage() async {
    if (imageFile != null) {
      File? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop',
          aspectRatioLockEnabled: false,
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: false,
        ),
      );

      if (cropped != null) {
        setState(() {
          imageFile = cropped;
        });
      }
    }
  }

  void _clearImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Crop Your Image"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: imageFile != null
                ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.file(imageFile!),
            )
                : const Center(
              child: Text("Add a picture"),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(icon: Icons.add, onpressed: _pickImage),
                  _buildIconButton(icon: Icons.crop, onpressed: _cropImage),
                  _buildIconButton(icon: Icons.clear, onpressed: _clearImage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      {required IconData icon, required void Function()? onpressed}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onpressed,
        icon: Icon(icon),
        color: Colors.white,
      ),
    );
  }
}
