import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BrightnessAdjustmentPage extends StatefulWidget {
  @override
  _BrightnessAdjustmentPageState createState() =>
      _BrightnessAdjustmentPageState();
}

class _BrightnessAdjustmentPageState extends State<BrightnessAdjustmentPage> {
  double _brightnessValue = 0.0; // Initial brightness value
  File? _imageFile; // Image file to be displayed

  @override
  void initState() {
    super.initState();
  }

  // Function to load the image from gallery
  void _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Function to update brightness value
  void _updateBrightness(double value) {
    setState(() {
      _brightnessValue = value;
    });
  }

  // Function to generate the ColorFilter with the adjusted brightness
  ColorFilter _generateColorFilter(double brightness) {
    return ColorFilter.matrix([
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  // Function to generate a thumbnail image from the original image file
  Widget _buildThumbnail() {
    if (_imageFile != null) {
      return ColorFiltered(
        colorFilter: _generateColorFilter(_brightnessValue),
        child: Image.file(
          _imageFile!,
          height: MediaQuery.of(context).size.height * 0.20, // Adjust the height of the thumbnail as needed
          width: MediaQuery.of(context).size.height * 0.20, // Adjust the width of the thumbnail as needed
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Text('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brightness Adjustment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildThumbnail(),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _brightnessValue,
                min: 0.0,
                max: 1.0,
                onChanged: _updateBrightness,
              ),
              Text('Brightness: ${_brightnessValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
