import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ShadowEffectPage()));
}

class ShadowEffectPage extends StatefulWidget {
  @override
  _ShadowEffectPageState createState() => _ShadowEffectPageState();
}

class _ShadowEffectPageState extends State<ShadowEffectPage> {
  double _shadowValue = 0.0; // Initial shadow value
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

  // Function to update shadow value
  void _updateShadow(double value) {
    setState(() {
      _shadowValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for shadow effect
  ColorFilter _generateShadowFilter(double shadow) {
    return ColorFilter.matrix([
      1, 0, 0, 0, shadow,
      0, 1, 0, 0, shadow,
      0, 0, 1, 0, shadow,
      0, 0, 0, 1, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shadow Effect'),
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
                    _generateShadowFilter(_shadowValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _shadowValue,
                min: 0.0,
                max: 100.0,
                onChanged: _updateShadow,
              ),
              Text('Shadow: ${_shadowValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
