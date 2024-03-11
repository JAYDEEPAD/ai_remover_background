import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: SaturationAdjustmentPage()));
}

class SaturationAdjustmentPage extends StatefulWidget {
  @override
  _SaturationAdjustmentPageState createState() =>
      _SaturationAdjustmentPageState();
}

class _SaturationAdjustmentPageState extends State<SaturationAdjustmentPage> {
  double _saturationValue = 1.0; // Initial saturation value
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

  // Function to update saturation value
  void _updateSaturation(double value) {
    setState(() {
      _saturationValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for saturation adjustment
  ColorFilter _generateSaturationFilter(double saturation) {
    return ColorFilter.matrix([
      0.2126 + 0.7874 * saturation, 0.7152 - 0.7152 * saturation,
      0.0722 - 0.0722 * saturation, 0, 0,
      0.2126 - 0.2126 * saturation, 0.7152 + 0.2848 * saturation,
      0.0722 - 0.0722 * saturation, 0, 0,
      0.2126 - 0.2126 * saturation, 0.7152 - 0.7152 * saturation,
      0.0722 + 0.9278 * saturation, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saturation Adjustment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading
                  ? CircularProgressIndicator()
                  : _imageFile != null
                  ? ColorFiltered(
                colorFilter: ColorFilter.matrix(
                    _generateSaturationFilter(_saturationValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _saturationValue,
                min: 0.0,
                max: 2.0,
                onChanged: _updateSaturation,
              ),
              Text('Saturation: ${_saturationValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
