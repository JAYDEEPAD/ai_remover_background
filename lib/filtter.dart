import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'home_screen.dart';
import 'provider.dart';

class Filter_Screen extends StatefulWidget {
  const Filter_Screen({Key? key}) : super(key: key);

  @override
  State<Filter_Screen> createState() => _Filter_ScreenState();
}

class _Filter_ScreenState extends State<Filter_Screen> {
  late AppImageProvider appImageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  late Uint8List filter1ImageBytes = Uint8List(0); // Byte data for Filter 1 image
  late Uint8List filter2ImageBytes = Uint8List(0); // Byte data for Filter 2 image



  @override
  void initState() {
    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    _loadFilterImages(); // Load filter images

  }

  Future<void> _loadFilterImages() async {
    // Load image data for Filter 1
    final ByteData filter1Data = await rootBundle.load('assets/image/ai1.png');
    filter1ImageBytes = filter1Data.buffer.asUint8List();

    // Load image data for Filter 2
    final ByteData filter2Data = await rootBundle.load('assets/image/ai2.png');
    filter2ImageBytes = filter2Data.buffer.asUint8List();

    setState(() {}); // Update UI after loading images
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
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Screenshot(
                controller: screenshotController,
                child: Image.memory(value.currentImage!),
              );
            }
            // If current image is null, show a progress indicator
            return Center(
              child: CircularProgressIndicator(),
            );
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
                  filterName: "Original",
                  filterImage: appImageProvider.currentImage!,
                  onPressed: () {
                    // Apply original filter or any other filter-specific logic
                  },
                ),
                _BottomButton(
                  filterName: "vivid",
                  filterImage: filter1ImageBytes, // Provide image data for Filter 1
                  onPressed: () {
                    // Apply Filter 1 or any other filter-specific logic
                  },
                ),
                _BottomButton(
                  filterName: "vivid cool",
                  filterImage: filter2ImageBytes, // Provide image data for Filter 2
                  onPressed: () {
                    // Apply Filter 2 or any other filter-specific logic
                  },
                ),
                // Add more buttons for additional filters
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _BottomButton({
    required String filterName,
    required Uint8List filterImage,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 40,
            child: Image.memory(
              filterImage,
              fit: BoxFit.cover,
            ),
          ),
          Text(filterName, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
