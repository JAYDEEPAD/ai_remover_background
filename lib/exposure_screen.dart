import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ExposureAdjustmentPage()));
}

class ExposureAdjustmentPage extends StatefulWidget {
  @override
  _ExposureAdjustmentPageState createState() => _ExposureAdjustmentPageState();
}

class _ExposureAdjustmentPageState extends State<ExposureAdjustmentPage> {
  double _exposureValue = 1.0; // Initial exposure value
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

  // Function to update exposure value
  void _updateExposure(double value) {
    setState(() {
      _exposureValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for exposure adjustment
  ColorFilter _generateExposureFilter(double exposure) {
    return ColorFilter.matrix([
      exposure, 0, 0, 0, 0,
      0, exposure, 0, 0, 0,
      0, 0, exposure, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exposure Adjustment'),
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
                    _generateExposureFilter(_exposureValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _exposureValue,
                min: 0.1,
                max: 2.0,
                onChanged: _updateExposure,
              ),
              Text('Exposure: ${_exposureValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
