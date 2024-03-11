import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: RotationFilterPage()));
}

class RotationFilterPage extends StatefulWidget {
  @override
  _RotationFilterPageState createState() => _RotationFilterPageState();
}

class _RotationFilterPageState extends State<RotationFilterPage> {
  double _rotationAngle = 0.0; // Initial rotation angle
  File? _imageFile; // Image file to be displayed
  bool _loading = false; // Loading indicator flag

  @override
  void initState() {
    super.initState();
  }

  // Function to load the image from gallery
  void _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _loading = true;
      });
      setState(() {
        _imageFile = File(pickedImage.path);
        _loading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  // Function to update rotation angle
  void _updateRotation(double value) {
    setState(() {
      _rotationAngle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotation Filter'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading
                  ? CircularProgressIndicator()
                  : _imageFile != null
                  ? Transform.rotate(
                angle: _rotationAngle,
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _rotationAngle,
                min: 0.0,
                max: 360.0,
                onChanged: _updateRotation,
              ),
              Text('Rotation Angle: ${_rotationAngle.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
