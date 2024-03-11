import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: VibrancyEffectPage()));
}

class VibrancyEffectPage extends StatefulWidget {
  @override
  _VibrancyEffectPageState createState() => _VibrancyEffectPageState();
}

class _VibrancyEffectPageState extends State<VibrancyEffectPage> {
  double _vibrancyValue = 0.0; // Initial vibrancy value
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

  // Function to update vibrancy value
  void _updateVibrancy(double value) {
    setState(() {
      _vibrancyValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for vibrancy effect
  List<double> _generateVibrancyMatrix(double vibrancy) {
    return [
      1 + 0.4 * vibrancy, 0, 0, 0, 0,
      0, 1 + 0.4 * vibrancy, 0, 0, 0,
      0, 0, 1 + 0.4 * vibrancy, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vibrancy Effect'),
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
                    _generateVibrancyMatrix(_vibrancyValue)),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _vibrancyValue,
                min: 0.0,
                max: 1.0,
                onChanged: _updateVibrancy,
              ),
              Text('Vibrancy: ${_vibrancyValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
