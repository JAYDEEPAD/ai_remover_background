import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: VignetteEffectPage()));
}

class VignetteEffectPage extends StatefulWidget {
  @override
  _VignetteEffectPageState createState() => _VignetteEffectPageState();
}

class _VignetteEffectPageState extends State<VignetteEffectPage> {
  double _vignetteValue = 0.0; // Initial vignette value
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

  // Function to update vignette value
  void _updateVignette(double value) {
    setState(() {
      _vignetteValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for vignette effect
  ColorFilter _generateVignetteFilter(double vignette) {
    return ColorFilter.matrix([
      vignette, 0, 0, 0, 0,
      0, vignette, 0, 0, 0,
      0, 0, vignette, 0, 0,
      0, 0, 0, 1.0 - vignette, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vignette Effect'),
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
                    _generateVignetteFilter(_vignetteValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _vignetteValue,
                min: 0.0,
                max: 1.0,
                onChanged: _updateVignette,
              ),
              Text('Vignette: ${_vignetteValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
