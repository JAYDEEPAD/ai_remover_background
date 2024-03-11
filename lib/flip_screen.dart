import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: FlipFilterPage()));
}

class FlipFilterPage extends StatefulWidget {
  @override
  _FlipFilterPageState createState() => _FlipFilterPageState();
}

class _FlipFilterPageState extends State<FlipFilterPage> {
  bool _isFlippedHorizontally = false;
  bool _isFlippedVertically = false;
  File? _imageFile;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flip Filter'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading
                  ? CircularProgressIndicator()
                  : _imageFile != null
                  ? Transform(
                transform: Matrix4.identity()
                  ..scale(
                    _isFlippedHorizontally ? -1.0 : 1.0,
                    _isFlippedVertically ? -1.0 : 1.0,
                  ),
                alignment: Alignment.center,
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isFlippedHorizontally,
                    onChanged: (value) {
                      setState(() {
                        _isFlippedHorizontally = value!;
                      });
                    },
                  ),
                  Text('Flip Horizontally'),
                  SizedBox(width: 20),
                  Checkbox(
                    value: _isFlippedVertically,
                    onChanged: (value) {
                      setState(() {
                        _isFlippedVertically = value!;
                      });
                    },
                  ),
                  Text('Flip Vertically'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
