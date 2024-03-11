import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: TemperatureFilterPage()));
}

class TemperatureFilterPage extends StatefulWidget {
  @override
  _TemperatureFilterPageState createState() => _TemperatureFilterPageState();
}

class _TemperatureFilterPageState extends State<TemperatureFilterPage> {
  double _temperatureValue = 0.0; // Initial temperature value
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

  // Function to update temperature value
  void _updateTemperature(double value) {
    setState(() {
      _temperatureValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for temperature adjustment
  List<double> _generateTemperatureMatrix(double temperature) {
    final double redMatrixValue = 1.0 + (0.15 * temperature);
    final double blueMatrixValue = 1.0 - (0.15 * temperature);
    return [
      redMatrixValue, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, blueMatrixValue, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Filter'),
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
                    _generateTemperatureMatrix(_temperatureValue)),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _temperatureValue,
                min: -1.0,
                max: 1.0,
                onChanged: _updateTemperature,
              ),
              Text('Temperature: ${_temperatureValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
