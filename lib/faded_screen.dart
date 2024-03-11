import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: FadedEffectPage()));
}

class FadedEffectPage extends StatefulWidget {
  @override
  _FadedEffectPageState createState() => _FadedEffectPageState();
}

class _FadedEffectPageState extends State<FadedEffectPage> {
  double _fadeValue = 0.0; // Initial fade value
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

  // Function to update fade value
  void _updateFade(double value) {
    setState(() {
      _fadeValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for faded effect
  ColorFilter _generateFadeFilter(double fade) {
    return ColorFilter.matrix([
      1.0, 0, 0, 0, fade,
      0, 1.0, 0, 0, fade,
      0, 0, 1.0, 0, fade,
      0, 0, 0, 1.0, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faded Effect'),
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
                    _generateFadeFilter(_fadeValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _fadeValue,
                min: 0.0,
                max: 1.0,
                onChanged: _updateFade,
              ),
              Text('Fade: ${_fadeValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
