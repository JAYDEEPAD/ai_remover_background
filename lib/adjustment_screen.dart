import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:ai_remover_background/filtter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';

class AdjustmentScreen extends StatefulWidget {
  final File orignalimageFile;
  final File imageFile;
  final ui.Image? filteredImage;


  AdjustmentScreen({Key? key, required this.orignalimageFile,required this.imageFile,this.filteredImage,
  }) : super(key: key);

  @override
  _AdjustmentScreenState createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5; // Initial slider value
  String _selectedFilterName = ''; // Initialize with an empty string
  GlobalKey _boundaryKey = GlobalKey();

  ui.Image? _filteredImage;


  @override
  void initState() {
    super.initState();
    _filteredImage = widget.filteredImage;
  }



  List<Map<String, dynamic>> iconDataList = [
    {"icon": Icons.highlight, "filterName": 'Highlight'},
    {"icon": Icons.brightness_medium, "filterName": 'Brightness'},
    {"icon": Icons.exposure, "filterName": 'Exposure'},
    {"icon": Icons.blur_circular, "filterName": 'Blur'},
    {"icon": Icons.face, "filterName": 'Fade'},
    {"icon": Icons.colorize, "filterName": 'Saturation'},
    {"icon": Icons.shutter_speed, "filterName": 'Shadow'},
    {"icon": Icons.vignette, "filterName": 'Vignette'},
    // Add more icons and filter names as needed
  ];

  bool _isIconButtonSelected = false;




  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
      if (_selectedFilter != null) {
        switch (_selectedFilterName) {
          case 'Brightness':
            _selectedFilter = _generateColorFilter(value);
            break;
          case 'Exposure':
            _selectedFilter = _generateExposureFilter(value);
            break;
          case 'Fade':
            _selectedFilter = _generateFadeFilter(value);
            break;
          case 'Highlight':
            _selectedFilter = _generateHighlightFilter(value);
            break;
          case 'Saturation':
            _selectedFilter = _generateSaturationFilter(value);
            break;
          case 'Shadow':
            _selectedFilter = _generateShadowFilter(value);
            break;
          case 'Blur':
            _selectedFilter = _generateBlurFilter(value);
            break;
          case 'Vignette':
            _selectedFilter = _generateVignetteFilter(value);
            break;
          default:
            break;
        }
      }
    });
  }

  void _navigateToFilterPage(BuildContext context, ui.Image? filteredImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(
          imageFile: widget.imageFile,
          filteredImage: _filteredImage,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Adjustments'),
        actions: [
          IconButton(
            onPressed: () {
              //_saveImageToGallery(context);
              _navigateToFilterPage(context,_filteredImage);

            },
            /*icon: Icon(Icons.download)*/
            icon: Icon(Icons.check,color: Colors.black,),          )
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if (_selectedFilter != null)
                      RepaintBoundary(
                        key: _boundaryKey,
                        child: ColorFiltered(
                          colorFilter: _selectedFilter!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.file(widget.orignalimageFile,fit: BoxFit.cover,),
                            ),
                          ),
                          /*Center(
                            child: ClipRect(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.55, // Specify the width
                                  height: MediaQuery.of(context).size.height * 0.45, // Specify the height
                                  child: Image.file(
                                    widget.orignalimageFile,
                                    fit: BoxFit.contain, // Adjust the image fit
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                        ),
                      )
                    else
                     /* Center(
                        child: ClipRect(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.55, // Specify the width
                              height: MediaQuery.of(context).size.height * 0.45, // Specify the height
                              child: Image.file(
                                widget.orignalimageFile,
                                fit: BoxFit.contain, // Adjust the image fit
                              ),
                            ),
                          ),
                        ),
                      ),*/
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.file(widget.orignalimageFile,fit: BoxFit.cover),
                        ),
                      ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: iconDataList.map((iconData) {
                          return _buildIconButton(iconData['icon'], iconData['filterName']);
                        }).toList(),
                      ),
                    ),
                    if (_isIconButtonSelected) // Conditionally show the slider
                      Column(
                        children: [
                          Slider(
                            value: _sliderValue,
                            min: 0.0,
                            max: 1.0,
                            onChanged: _updateSliderValue,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


 /* Widget _buildIconButton(IconData icon, String filterName) {
    final bool isSelected = _selectedFilterName == filterName;
    final buttonColor = isSelected ? Colors.blue : null;
    final textColor = isSelected ? Colors.white : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          _applyFilterByName(filterName);
          setState(() {
            _isIconButtonSelected = true; // Toggle the boolean variable
          });
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: textColor,
        ),
        icon: Icon(icon),
        label: Text(filterName),
      ),
    );
  }
*/



  Widget _buildIconButton(IconData icon, String filterName) {
    final bool isSelected = _selectedFilterName == filterName;
    final buttonColor = isSelected ? Colors.deepPurple[200] : null;
    final textColor = isSelected ? Colors.white : null;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor ?? Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  _applyFilterByName(filterName);
                  setState(() {
                    _isIconButtonSelected = true; // Toggle the boolean variable
                  });
                },
                icon: Icon(icon, color: Colors.white,),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            filterName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  void _applyFilterByName(String filterName) {
    setState(() {
      _selectedFilterName = filterName;
      switch (filterName) {
        case 'Highlight':
          _selectedFilter = _generateHighlightFilter(_sliderValue);
          break;

        case 'Brightness':
          _selectedFilter = _generateColorFilter(_sliderValue);
          break;
        case 'Exposure':
          _selectedFilter = _generateExposureFilter(_sliderValue);
          break;
        case 'Blur':
          _selectedFilter = _generateBlurFilter(_sliderValue);
          break;
        case 'Fade':
          _selectedFilter = _generateFadeFilter(_sliderValue);
          break;
        case 'Saturation':
          _selectedFilter = _generateSaturationFilter(_sliderValue);
          break;
        case 'Shadow':
          _selectedFilter = _generateShadowFilter(_sliderValue);
          break;

        case 'Vignette':
          _selectedFilter = _generateVignetteFilter(_sliderValue);
          break;

      // Add cases for other filter names
        default:
          break;
      }

      _captureFilteredImage().then((image) {
        setState(() {
          _filteredImage = image;
        });
      });

    });
  }





  void _saveImageToGallery(context) async {
    try {
      ui.Image? filteredImage = await _captureFilteredImage();
      if (filteredImage != null) {
        ByteData? byteData = await filteredImage.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        img.Image? image = img.decodeImage(pngBytes);
        if (image != null) {
          Uint8List? jpegBytes = img.encodeJpg(image, quality: 90) as Uint8List?;
          await ImageGallerySaver.saveImage(jpegBytes!);
          Fluttertoast.showToast(
            msg: ' save image to Gallary',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          //firebase
          User? user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            throw Exception('User not authenticated');
          }

          final DateTime uploadTime = DateTime.now();
          print(uploadTime);
          final storageRef = FirebaseStorage.instance.ref().child('users/${user.uid}/images/${DateTime.now().millisecondsSinceEpoch}.png');
          print(storageRef);
          final uploadTask = storageRef.putData(pngBytes);
          print(uploadTask);
          final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
          print(downloadUrl);
          final String url = await downloadUrl.ref.getDownloadURL();
          print(url);

          await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('images').add({
            'imageUrl': url,
            'uploadTime': uploadTime.toIso8601String(),
          });
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to convert image',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );

        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to save image',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      print(e);
    }
  }



  Future<ui.Image?> _captureFilteredImage() async {
    try {
      RenderRepaintBoundary boundary =
      _boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Define the target width and height
      final targetWidth = 700;
      final targetHeight = 700;

      // Calculate the pixel ratio required to achieve the target resolution
      final pixelRatio = (targetWidth / boundary.size.width).clamp(1.0, double.infinity);

      // Capture the image at the desired resolution
      ui.Image? image = await boundary.toImage(pixelRatio: pixelRatio);

      return image;
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }



  ColorFilter _generateColorFilter(double brightness) {
    return ColorFilter.matrix([
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateExposureFilter(double exposure) {
    return ColorFilter.matrix([
      exposure,
      0,
      0,
      0,
      0,
      0,
      exposure,
      0,
      0,
      0,
      0,
      0,
      exposure,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateFadeFilter(double fade) {
    return ColorFilter.matrix([
      1.0,
      0,
      0,
      0,
      fade,
      0,
      1.0,
      0,
      0,
      fade,
      0,
      0,
      1.0,
      0,
      fade,
      0,
      0,
      0,
      1.0,
      0,
    ]);
  }

  ColorFilter _generateBlurFilter(double blurValue) {
    return ColorFilter.matrix([
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      blurValue * blurValue.toDouble(), // Adjust the last value to control the blur strength
      0,
    ]);
  }

  ColorFilter _generateHighlightFilter(double highlight) {
    return ColorFilter.matrix([
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateSaturationFilter(double saturation) {
    return ColorFilter.matrix([
      0.2126 + 0.7874 * saturation,
      0.7152 - 0.7152 * saturation,
      0.0722 - 0.0722 * saturation,
      0,
      0,
      0.2126 - 0.2126 * saturation,
      0.7152 + 0.2848 * saturation,
      0.0722 - 0.0722 * saturation,
      0,
      0,
      0.2126 - 0.2126 * saturation,
      0.7152 - 0.7152 * saturation,
      0.0722 + 0.9278 * saturation,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateShadowFilter(double shadow) {
    return ColorFilter.matrix([
      1,
      0,
      0,
      0,
      shadow,
      0,
      1,
      0,
      0,
      shadow,
      0,
      0,
      1,
      0,
      shadow,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateVignetteFilter(double vignette) {
    return ColorFilter.matrix([
      vignette,
      0,
      0,
      0,
      0,
      0,
      vignette,
      0,
      0,
      0,
      0,
      0,
      vignette,
      0,
      0,
      0,
      0,
      0,
      1.0 - vignette,
      0,
    ]);
  }

}
