import 'dart:typed_data';
import 'package:ai_remover_background/home_screen.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class Adjustment_Screen extends StatefulWidget {
  const Adjustment_Screen({super.key});

  @override
  State<Adjustment_Screen> createState() => _Adjustment_ScreenState();
}

// class _Adjustment_ScreenState extends State<Adjustment_Screen> {
//   late AppImageProvider appImageProvider;
//   late ColorFilterGenerator adj;
//   ScreenshotController screenshotController = ScreenshotController();
//
//    double brightness = 0;
//   double contrast = 0;
//   double saturation = 0;
//   double hue = 0;
//   double sepia = 0;
//
//   bool showbrightness = true;
//   bool showcontrast = false;
//   bool showsaturation = false;
//   bool showhue = false;
//   bool showsepia = false;
//
//   String Selected = 'brightness';
//   adjust({ b ,c,s,h,se}){
//    adj = ColorFilterGenerator(name: 'Adjust',
//        filters:[
//          ColorFilterAddons.brightness(b ?? brightness),
//          ColorFilterAddons.contrast(c ?? contrast),
//          ColorFilterAddons.saturation(s ??saturation),
//          ColorFilterAddons.hue(h ?? hue),
//          ColorFilterAddons.sepia(se ?? sepia),
//
//    ]);
//   }
//   showSlider({ b ,c,s,h,se}){
//     setState(() {
//     showbrightness=  b != null ? true : false;
//     showcontrast= c != null ? true : false;
//     showsaturation= s != null ? true : false;
//     showhue= h != null ? true : false;
//     showsepia= se != null ? true : false;
//     });
// }
//   @override
//   void initState() {
//     super.initState();
//     adjust();
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff212121),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text("Adjustment Screen",style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//             },
//             icon: Icon(Icons.close,color: Colors.white,)),
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 Uint8List? byte = await screenshotController.capture();
//                 appImageProvider.changeImage(byte!);
//                 if (!mounted) return;
//                 Navigator.of(context).pop();
//               }, icon: Icon(Icons.check,color: Colors.white,)),
//         ],
//       ),
//       body:
//       Stack(
//         children: [
//           Center(
//             child: Consumer<AppImageProvider>(
//               builder: (BuildContext context, value, Widget? child) {
//                 if (value.currentImage != null) {
//                   return Screenshot(
//                     controller: screenshotController,
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.matrix(
//                         adj.matrix
//                       ),
//                         child: Image.memory(value.currentImage!),
//                     ),
//                   );
//                 }
//                 // If current image is null, show a progress indicator
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                      Visibility(
//                        visible:showbrightness,
//                        child: slider(
//                          value:brightness,
//                          onChanged: (value){
//                           setState(() {
//                             brightness = value;
//                             adjust(b: brightness);
//                           });
//                          },
//                        ),
//                      ),
//                       Visibility(
//                         visible:showcontrast,
//                         child: slider(
//                           value:contrast,
//                           onChanged: (value){
//                             setState(() {
//                               contrast = value;
//                               adjust(c: contrast);
//                             });
//                           },
//                         ),
//                       ),
//                       Visibility(
//                         visible:showsaturation,
//                         child: slider(
//                           value:saturation,
//                           onChanged: (value){
//                             setState(() {
//                               saturation = value;
//                               adjust(s: saturation);
//                             });
//                           },
//                         ),
//                       ),
//                       Visibility(
//                         visible:showhue,
//                         child: slider(
//                           value:hue,
//                           onChanged: (value){
//                             setState(() {
//                               hue = value;
//                               adjust(h: hue);
//                             });
//                           },
//                         ),
//                       ),
//                       Visibility(
//                         visible:showsepia,
//                         child: slider(
//                           value:sepia,
//                           onChanged: (value){
//                             setState(() {
//                               sepia = value;
//                               adjust(se: sepia);
//                             });
//                           },
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 TextButton(onPressed: (){
//                   setState(() {
//                     brightness = 0;
//                     contrast = 0;
//                     saturation = 0;
//                     hue = 0;
//                     sepia = 0;
//                     adjust(
//                         b: brightness,
//                       c: contrast,
//                       s: saturation,
//                       h: hue,
//                       se: sepia,
//
//                     );
//                   });
//                 }, child: Text("Reset"),),
//
//               ],
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 58,
//         width: double.infinity,
//         color: Colors.black,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 _BottomButton(
//                     Icons.brightness_4,
//                     'Brightness',
//                     color: showbrightness ? Colors.blue : null,
//                     onPressed:(){
//                       Selected = 'Brightness';
//                      showSlider(b: true);
//                     }
//                 ),
//                 _BottomButton(
//                     Icons.contrast,
//                     'Contrast',
//                     color: showcontrast ? Colors.blue : null,
//                     onPressed:(){
//                       Selected = 'Contrast';
//                       showSlider(c: true);
//                     }
//                 ),
//                 _BottomButton(
//                     Icons.water_drop ,
//                     'Saturation',
//                     color: showsaturation ? Colors.blue : null,
//                     onPressed:(){
//                       Selected = 'Saturation';
//                       showSlider(s: true);
//                     }
//                 ),
//                 _BottomButton(
//                     Icons.filter_tilt_shift,
//                     'Hue',
//                     color: showhue ? Colors.blue : null,
//                     onPressed:(){
//                       Selected = 'Hue';
//                       showSlider(h: true);
//                     }
//                 ),
//                 _BottomButton(
//                     Icons.motion_photos_on,
//                     'Sepia',
//                     color: showsepia ? Colors.blue : null,
//                     onPressed:(){
//                       Selected = 'Sepia';
//                       showSlider(se: true);
//                     }
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _BottomButton(IconData icon , String title ,{Color? color,required onPressed}){
//     return  InkWell(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//         child: Column(
//           children: [
//             Icon(icon,color: color ?? Colors.white,),
//             Text(title,style: TextStyle(color: color ?? Colors.white70),),
//
//           ],
//         ),
//       ),
//     );
//   }
//   Widget slider({label, value, onChanged}){
//     return  Slider(
//       label: '${value.toStringAsFixed(2)}',
//         value: value,
//         max: 1,
//         min: -0.9,
//         onChanged: onChanged
//     );
//   }
// }
class _Adjustment_ScreenState extends State<Adjustment_Screen> {
  late AppImageProvider appImageProvider;
  late ColorFilterGenerator adj;
  ScreenshotController screenshotController = ScreenshotController();
  double brightness = 0;
  double contrast = 0;
  double saturation = 0;
  double hue = 0;
  double sepia = 0;
  double auto = 0;
  bool showauto = false;
  bool showbrightness = true;
  bool showcontrast = false;
  bool showsaturation = false;
  bool showhue = false;
  bool showsepia = false;

  String Selected = 'brightness';

  // Method to calculate auto-adjusted brightness
  double calculateAutoBrightness(Uint8List imageData) {
    // Initialize total brightness
    int totalBrightness = 0;

    // Calculate total brightness by summing up pixel values
    for (int i = 0; i < imageData.length; i += 4) {
      // Extract RGB values from the image data
      int r = imageData[i];
      int g = imageData[i + 1];
      int b = imageData[i + 2];

      // Convert RGB to brightness value (YUV formula: 0.299R + 0.587G + 0.114B)
      int brightness = (0.299 * r + 0.587 * g + 0.114 * b).round();

      // Add brightness to the total
      totalBrightness += brightness;
    }

    // Calculate average brightness
    double averageBrightness = totalBrightness / (imageData.length ~/ 4);

    // Calculate the adjustment value based on the difference from the desired average brightness
    double adjustment = 0.5 - averageBrightness / 255.0; // 0.5 is the desired average brightness

    return adjustment;
  }

  double calculateAutoContrast(Uint8List imageData) {
    // Calculate the average pixel intensity
    double totalIntensity = 0;
    for (int i = 0; i < imageData.length; i += 4) {
      totalIntensity += (imageData[i] + imageData[i + 1] + imageData[i + 2]) / 3;
    }
    double averageIntensity = totalIntensity / (imageData.length ~/ 4);

    // Calculate the adjustment based on the difference from the average intensity
    double adjustment = (128 - averageIntensity) / 255.0;

    return adjustment;
  }

  double calculateAutoSaturation(Uint8List imageData) {
    // Convert RGB to HSL (Hue, Saturation, Lightness)
    List<double> hsl = [0, 0, 0];
    for (int i = 0; i < imageData.length; i += 4) {
      double r = imageData[i] / 255;
      double g = imageData[i + 1] / 255;
      double b = imageData[i + 2] / 255;

      double cmax = [r, g, b].reduce((value, element) => value > element ? value : element);
      double cmin = [r, g, b].reduce((value, element) => value < element ? value : element);
      double delta = cmax - cmin;

      double h = 0;
      if (delta != 0) {
        if (cmax == r) {
          h = 60 * (((g - b) / delta) % 6);
        } else if (cmax == g) {
          h = 60 * (((b - r) / delta) + 2);
        } else if (cmax == b) {
          h = 60 * (((r - g) / delta) + 4);
        }
      }

      hsl[0] += h;
      hsl[1] += delta / (1 - (cmax + cmin));
      hsl[2] += (cmax + cmin) / 2;
    }

    hsl[0] /= (imageData.length ~/ 4);
    hsl[1] /= (imageData.length ~/ 4);
    hsl[2] /= (imageData.length ~/ 4);

    // Calculate the adjustment based on the average saturation
    double adjustment = hsl[1] - 0.5;

    return adjustment;
  }

  double calculateAutoHue(Uint8List imageData) {
    // Convert RGB to HSL (Hue, Saturation, Lightness)
    List<double> hsl = [0, 0, 0];
    for (int i = 0; i < imageData.length; i += 4) {
      double r = imageData[i] / 255;
      double g = imageData[i + 1] / 255;
      double b = imageData[i + 2] / 255;

      double cmax = [r, g, b].reduce((value, element) => value > element ? value : element);
      double cmin = [r, g, b].reduce((value, element) => value < element ? value : element);
      double delta = cmax - cmin;

      double h = 0;
      if (delta != 0) {
        if (cmax == r) {
          h = 60 * (((g - b) / delta) % 6);
        } else if (cmax == g) {
          h = 60 * (((b - r) / delta) + 2);
        } else if (cmax == b) {
          h = 60 * (((r - g) / delta) + 4);
        }
      }

      hsl[0] += h;
      hsl[1] += delta / (1 - (cmax + cmin));
      hsl[2] += (cmax + cmin) / 2;
    }

    hsl[0] /= (imageData.length ~/ 4);

    // Calculate the adjustment based on the average hue
    double adjustment = (hsl[0] - 180) / 360.0; // Centering around 180° (green)

    return adjustment;
  }

  double calculateAutoSepia(Uint8List imageData) {
    // Calculate the average intensity
    double totalIntensity = 0;
    for (int i = 0; i < imageData.length; i += 4) {
      totalIntensity += (imageData[i] + imageData[i + 1] + imageData[i + 2]) / 3;
    }
    double averageIntensity = totalIntensity / (imageData.length ~/ 4);

    // Calculate the adjustment based on the average intensity
    double adjustment = averageIntensity / 255.0;

    return adjustment;
  }


  adjust({a,b, c, s, h, se}) {
    adj = ColorFilterGenerator(
        name: 'Adjust',
        filters: [
          ColorFilterAddons.brightness(b ?? brightness),
          ColorFilterAddons.contrast(c ?? contrast),
          ColorFilterAddons.saturation(s ?? saturation),
          ColorFilterAddons.hue(h ?? hue),
          ColorFilterAddons.sepia(se ?? sepia),
          ColorFilterAddons.colorOverlay(3, 3, 5, a ?? auto),
        ]);
  }

  showSlider({a,b, c, s, h, se}) {
    setState(() {
      showauto = a != null ? true :false;
      showbrightness = b != null ? true : false;
      showcontrast = c != null ? true : false;
      showsaturation = s != null ? true : false;
      showhue = h != null ? true : false;
      showsepia = se != null ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    adjust();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Adjustment Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.close, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () async {
                Uint8List? byte = await screenshotController.capture();
                appImageProvider.changeImage(byte!);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.check, color: Colors.white)),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Consumer<AppImageProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.currentImage != null) {
                  return
                    Screenshot(
                      controller: screenshotController,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(adj.matrix),
                        child: Image.memory(value.currentImage!),
                      ),
                    );
                }
                // If current image is null, show a progress indicator
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*Visibility(
                        visible: showauto,
                        child: slider(
                          value: auto,
                          onChanged: (value) {
                            setState(() {
                              auto = value;
                              adjust(a: auto);
                            });
                          },
                        ),
                      ),*/
                      Visibility(
                        visible: showbrightness,
                        child: slider(
                          value: brightness,
                          onChanged: (value) {
                            setState(() {
                              brightness = value;
                              adjust(b: brightness);
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: showcontrast,
                        child: slider(
                          value: contrast,
                          onChanged: (value) {
                            setState(() {
                              contrast = value;
                              adjust(c: contrast);
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: showsaturation,
                        child: slider(
                          value: saturation,
                          onChanged: (value) {
                            setState(() {
                              saturation = value;
                              adjust(s: saturation);
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: showhue,
                        child: slider(
                          value: hue,
                          onChanged: (value) {
                            setState(() {
                              hue = value;
                              adjust(h: hue);
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: showsepia,
                        child: slider(
                          value: sepia,
                          onChanged: (value) {
                            setState(() {
                              sepia = value;
                              adjust(se: sepia);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      brightness = 0;
                      contrast = 0;
                      saturation = 0;
                      hue = 0;
                      sepia = 0;
                      adjust(
                        b: brightness,
                        c: contrast,
                        s: saturation,
                        h: hue,
                        se: sepia,
                      );
                    });
                  },
                  child: Text("Reset"),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 58,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),

                _BottomButton(
                    Icons.auto_fix_high,
                    'Auto',
                    color: showauto ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Auto';
                      showSlider(a: true);
                      autoAdjust();
                    }),
                _BottomButton(
                    Icons.brightness_4,
                    'Brightness',
                    color: showbrightness ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Brightness';
                      showSlider(b: true);
                    }),
                _BottomButton(
                    Icons.contrast,
                    'Contrast',
                    color: showcontrast ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Contrast';
                      showSlider(c: true);
                    }),
                _BottomButton(
                    Icons.water_drop,
                    'Saturation',
                    color: showsaturation ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Saturation';
                      showSlider(s: true);
                    }),
                _BottomButton(
                    Icons.filter_tilt_shift,
                    'Hue',
                    color: showhue ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Hue';
                      showSlider(h: true);
                    }),
                _BottomButton(
                    Icons.motion_photos_on,
                    'Sepia',
                    color: showsepia ? Colors.blue : null,
                    onPressed: () {
                      Selected = 'Sepia';
                      showSlider(se: true);
                    }),
                // Button for auto adjustment

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to auto-adjust all filters
  // Method to auto-adjust all filters
  void autoAdjust() async {
    // Get the current image data
    Uint8List imageData = await getCurrentImageData();

    // Calculate auto-adjusted values for each filter
    double autoBrightness = calculateAutoBrightness(imageData);
    double autoContrast = calculateAutoContrast(imageData);
    double autoSaturation = calculateAutoSaturation(imageData);
    double autoHue = calculateAutoHue(imageData);
    double autoSepia = calculateAutoSepia(imageData);

    // Assign static values for adjustments
    double staticBrightness = 0.5; // Example static value for brightness
    double staticContrast = 0.3; // Example static value for contrast
    double staticSaturation = 0.2; // Example static value for saturation
    double staticHue = 0.1; // Example static value for hue
    double staticSepia = 0.4; // Example static value for sepia

    // Update the state with auto-adjusted values
    // Update the state with auto-adjusted values clamped within the valid range
    setState(() {
      brightness = autoBrightness.clamp(-0.9, 1.0);
      contrast = autoContrast.clamp(-0.9, 1.0);
      saturation = autoSaturation.clamp(-0.9, 1.0);
      hue = autoHue.clamp(-0.9, 1.0);
      sepia = autoSepia.clamp(-0.9, 1.0);
      adjust(
        a: autoBrightness.clamp(-0.9, 1.0), // Adjusted for auto slider
        b: staticBrightness,
        c: staticContrast,
        s: staticSaturation,
        h: staticHue,
        se: staticSepia,
      );
      // Update the visibility of sliders based on the selected filter
      switch (Selected) {
        case 'Auto':
          showSlider(a: true);
          break;
        case 'Brightness':
          showSlider(b: true);
          break;
        case 'Contrast':
          showSlider(c: true);
          break;
        case 'Saturation':
          showSlider(s: true);
          break;
        case 'Hue':
          showSlider(h: true);
          break;
        case 'Sepia':
          showSlider(se: true);
          break;
        default:
          showSlider();
      }
    });
  }

  // Method to get the current image data
  Future<Uint8List> getCurrentImageData() async {
    // Retrieve the current image data from the provider
    AppImageProvider appImageProvider =
    Provider.of<AppImageProvider>(context, listen: false);
    Uint8List? imageData = appImageProvider.currentImage;
    if (imageData == null) {
      throw Exception('No image data available');
    }
    return imageData;
  }

  Widget _BottomButton(IconData icon, String title,
      {Color? color, required onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            Icon(
              icon,
              color: color ?? Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: color ?? Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget slider({label, value, onChanged}) {
    return Slider(
        label: '${value.toStringAsFixed(2)}',
        value: value,
        max: 1,
        min: -0.9,
        onChanged: onChanged);
  }
}