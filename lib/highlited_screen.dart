import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: HighlightEffectPage()));
}

class HighlightEffectPage extends StatefulWidget {
  @override
  _HighlightEffectPageState createState() => _HighlightEffectPageState();
}

class _HighlightEffectPageState extends State<HighlightEffectPage> {
  double _highlightValue = 0.0; // Initial highlight value
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

  // Function to update highlight value
  void _updateHighlight(double value) {
    setState(() {
      _highlightValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for highlight effect
  ColorFilter _generateHighlightFilter(double highlight) {
    return ColorFilter.matrix([
      1 + highlight, 0, 0, 0, 0,
      0, 1 + highlight, 0, 0, 0,
      0, 0, 1 + highlight, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highlight Effect'),
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
                    _generateHighlightFilter(_highlightValue) as List<double>),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _highlightValue,
                min: 0.0,
                max: 1.0,
                onChanged: _updateHighlight,
              ),
              Text('Highlight: ${_highlightValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
