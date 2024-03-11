import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ContrastFilterPage()));
}

class ContrastFilterPage extends StatefulWidget {
  @override
  _ContrastFilterPageState createState() => _ContrastFilterPageState();
}

class _ContrastFilterPageState extends State<ContrastFilterPage> {
  double _contrastValue = 1.0; // Initial contrast value
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

  // Function to update contrast value
  void _updateContrast(double value) {
    setState(() {
      _contrastValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for contrast adjustment
  List<double> _generateContrastMatrix(double contrast) {
    return [
      contrast, 0, 0, 0, 0,
      0, contrast, 0, 0, 0,
      0, 0, contrast, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Filter'),
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
                    _generateContrastMatrix(_contrastValue)),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _contrastValue,
                min: 0.0,
                max: 2.0,
                onChanged: _updateContrast,
              ),
              Text('Contrast: ${_contrastValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
