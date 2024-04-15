import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'home_screen.dart';
import 'provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late AppImageProvider appImageProvider;
  late Future<void> _initProviderFuture;
  ScreenshotController screenshotController = ScreenshotController();

  late Uint8List filter1ImageBytes = Uint8List(0); // Byte data for Filter 1 image
  late Uint8List filter2ImageBytes = Uint8List(0); // Byte data for Filter 2 image

  // Maintain the currently applied filter
  FilterType? _currentFilter;

  @override
  void initState() {
    super.initState();
    _initProviderFuture = _initProvider();
  }

  Future<void> _initProvider() async {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    await _loadFilterImages(); // Load filter images
  }

  Future<void> _loadFilterImages() async {
    final ByteData filter1Data = await rootBundle.load('assets/image/ai1.png');
    filter1ImageBytes = filter1Data.buffer.asUint8List();

    final ByteData filter2Data = await rootBundle.load('assets/image/ai2.png');
    filter2ImageBytes = filter2Data.buffer.asUint8List();

    setState(() {}); // Update UI after loading images
  }

  void applyFilter(Uint8List filterImage, FilterType filterType) {
    appImageProvider.changeImage(filterImage);
    setState(() {
      _currentFilter = filterType; // Update the current filter
    });
  }

  void applyOriginalImage() {
    appImageProvider.changeImage(appImageProvider.originalImage); // Reset to original image
    setState(() {
      _currentFilter = null; // No filter applied
    });
  }
  Uint8List? _applyVividFilter(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      return null; // Handle decoding failure
    }

    // Apply vivid filter effects
    final double saturationFactor = 1.5;
    final double brightnessFactor = 1.2;

    img.adjustColor(image, saturation: saturationFactor);
    img.adjustColor(image, brightness: brightnessFactor);

    // Encode the modified image back to Uint8List
    return img.encodePng(image);
  }

  Uint8List? _applySepiaFilter(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      return null; // Handle decoding failure
    }

    // Apply sepia filter effects
    img.colorOffset(image, red: 0.5, green: 0.3, blue: 0.1);

    // Encode the modified image back to Uint8List
    return img.encodePng(image);
  }

  Uint8List? _applyNoirFilter(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      return null; // Handle decoding failure
    }

    // Apply noir filter effects (convert image to grayscale)
    img.grayscale(image);

    final double contrastFactor = 1.5;

    img.adjustColor(image, contrast: contrastFactor);
    // Encode the modified image back to Uint8List
    return img.encodePng(image);
  }

  Uint8List? _applySilvertoneFilter(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);

    if (image == null) {
      return null; // Handle decoding failure
    }

    // Apply noir filter effects (convert image to grayscale)
    /*img.grayscale(image);*/

    final double contrastFactor = 1.2;

    img.adjustColor(image, contrast: contrastFactor);
    img.grayscale(image);
    // Encode the modified image back to Uint8List
    return img.encodePng(image);
  }

  Uint8List? _applyMonoFilter(Uint8List imageData) {
    img.Image? image = img.decodeImage(imageData);
    if (image == null) {
      return null; // Handle decoding failure
    }

    // Convert image to grayscale
    img.grayscale(image);

    // Encode the modified image back to Uint8List
    return img.encodePng(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Filters",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Uint8List? byte = await screenshotController.capture();
              appImageProvider.changeImage(byte!);
              if (!mounted) return;
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _initProviderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.currentImage != null) {
                    return Screenshot(
                      controller: screenshotController,
                      child: Image.memory(value.currentImage!),
                    );
                  }
                  // If current image is null, show a progress indicator
                  return CircularProgressIndicator();
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _BottomButton(
                  filterType: FilterType.Original,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    applyOriginalImage();
                    // Do nothing for the original image
                  },
                ),
                _BottomButton(
                  filterType: FilterType.Vivid,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    // Apply filter only if it's not already applied
                    if (_currentFilter != FilterType.Vivid) {
                      Uint8List? modifiedImageData = _applyVividFilter(appImageProvider.currentImage!);
                      if (modifiedImageData != null) {
                        applyFilter(modifiedImageData, FilterType.Vivid);
                      } else {
                        // Handle the case where filter application fails
                      }
                    }
                  },
                ),
                _BottomButton(
                  filterType: FilterType.Sepia,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    // Apply filter only if it's not already applied
                    if (_currentFilter != FilterType.Sepia) {
                      Uint8List? modifiedImageData = _applySepiaFilter(appImageProvider.currentImage!);
                      if (modifiedImageData != null) {
                        applyFilter(modifiedImageData, FilterType.Sepia);
                      } else {
                        // Handle the case where filter application fails
                      }
                    }
                  },
                ),
                _BottomButton(
                  filterType: FilterType.Noir,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    // Apply filter only if it's not already applied
                    if (_currentFilter != FilterType.Noir) {
                      Uint8List? modifiedImageData = _applyNoirFilter(appImageProvider.currentImage!);
                      if (modifiedImageData != null) {
                        applyFilter(modifiedImageData, FilterType.Noir);
                      } else {
                        // Handle the case where filter application fails
                      }
                    }
                  },
                ),
                _BottomButton(
                  filterType: FilterType.Silvertone,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    // Apply filter only if it's not already applied
                    if (_currentFilter != FilterType.Silvertone) {
                      Uint8List? modifiedImageData = _applySilvertoneFilter(appImageProvider.currentImage!);
                      if (modifiedImageData != null) {
                        applyFilter(modifiedImageData, FilterType.Silvertone);
                      } else {
                        // Handle the case where filter application fails
                      }
                    }
                  },
                ),
                _BottomButton(
                  filterType: FilterType.Mono,
                  currentFilter: _currentFilter,
                  onPressed: () {
                    // Apply filter only if it's not already applied
                    if (_currentFilter != FilterType.Mono) {
                      Uint8List? modifiedImageData = _applyMonoFilter(appImageProvider.currentImage!);
                      if (modifiedImageData != null) {
                        applyFilter(modifiedImageData, FilterType.Mono);
                      } else {
                        // Handle the case where filter application fails
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _BottomButton({
    required FilterType filterType,
    required FilterType? currentFilter,
    required VoidCallback onPressed,
  }) {
    String filterName;
    Uint8List filterImage;

    // Determine the filter name and image based on the filter type
    switch (filterType) {
      case FilterType.Original:
        filterName = "Original";
        filterImage = appImageProvider.currentImage!;
        break;
      case FilterType.Vivid:
        filterName = "Vivid";
        filterImage = appImageProvider.currentImage!;
        break;
      case FilterType.Sepia:
        filterName = "Sepia";
        filterImage = appImageProvider.currentImage!;
        break;
      case FilterType.Noir:
        filterName = "Noir";
        filterImage = appImageProvider.currentImage!;
        break;
      case FilterType.Silvertone:
        filterName = "Silvertone";
        filterImage = appImageProvider.currentImage!;
        break;
      case FilterType.Mono:
        filterName = "Mono";
        filterImage = appImageProvider.currentImage!;
        break;
    }

    // Determine if this button corresponds to the currently applied filter
    bool isActive = filterType == currentFilter;

    // Define the color for the active filter
    Color activeColor = Colors.blue; // Change this color as needed

    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              border: isActive ? Border.all(color: activeColor, width: 2) : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.memory(
              filterImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(filterName, style: TextStyle(color: isActive ? activeColor : Colors.white)),
        ],
      ),
    );
  }
}

enum FilterType {
  Original,
  Vivid,
  Sepia,
  Noir,
  Silvertone,
  Mono
  // Add more filter types here
}
