// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:projects/model/filter.dart';
// // // import 'package:projects/widgets/homescreen.dart';
// // // import 'package:projects/widgets/provider.dart';
// // // import 'package:provider/provider.dart';
// // //
// // // import '../startscreen.dart';
// // // class Filter_Screen extends StatefulWidget {
// // //   const Filter_Screen({super.key});
// // //
// // //   @override
// // //   State<Filter_Screen> createState() => _Filter_ScreenState();
// // // }
// // //
// // // class _Filter_ScreenState extends State<Filter_Screen> {
// // //   late Filter currentFilter;
// // //   late List<Filter> filters;
// // //   @override
// // //   void initState() {
// // //     // TODO: implement initState
// // //       filters = Filters().list();
// // //     currentFilter = filters[0];
// // //     super.initState();
// // //   }
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.black,
// // //         title: Text("Filters",style: TextStyle(color: Colors.white),),
// // //         centerTitle: true,
// // //         leading: IconButton(
// // //             onPressed: (){
// // //               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
// // //             },
// // //             icon: Icon(Icons.close,color: Colors.white,)),
// // //         actions: [
// // //           IconButton(onPressed: () async {
// // //
// // //
// // //           }, icon: Icon(Icons.check,color: Colors.white,)),
// // //         ],
// // //       ),
// // //       body: Center(
// // //         child: Consumer<AppImageProvider>(
// // //             builder: (BuildContext context, value, Widget? child) {
// // //               if (value.currentImage != null) {
// // //                 return ColorFiltered(
// // //                   colorFilter: ColorFilter.matrix(
// // //                          currentFilter.matrix
// // //                   ),
// // //                     child: Image.memory(value.currentImage!));
// // //
// // //               }
// // //               return Center(
// // //                 child: CircularProgressIndicator(),
// // //               );
// // //             }),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'dart:typed_data';
// //
// // import 'package:flutter/material.dart';
// // import 'package:projects/model/filter.dart'; // Import your Filter class here
// // import 'package:projects/widgets/homescreen.dart'; // Import HomeScreen if not already imported
// // import 'package:projects/widgets/provider.dart';
// // import 'package:provider/provider.dart';
// // import 'package:screenshot/screenshot.dart';
// //
// // import '../helper/filters_s.dart';
// //
// // class Filter_Screen extends StatefulWidget {
// //   const Filter_Screen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Filter_Screen> createState() => _Filter_ScreenState();
// // }
// //
// // class _Filter_ScreenState extends State<Filter_Screen> {
// //   late Filter currentFilter;
// //   late List<Filter> filters;
// //    late AppImageProvider appImageProvider;
// //    ScreenshotController screenshotController = ScreenshotController();
// //   @override
// //   void initState() {
// //
// //     // Initialize your filters list here
// //
// //    // currentFilter = filters[0];
// //
// //     appImageProvider = Provider.of<AppImageProvider>(context,listen: false);
// //     super.initState();
// //     // Set initial filter
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: Text(
// //           "Filters",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         centerTitle: true,
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (context) => HomeScreen()),
// //             );
// //           },
// //           icon: Icon(Icons.close, color: Colors.white),
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () async {
// //              Uint8List? byte = await screenshotController.capture();
// //              appImageProvider.changeImage(byte!);
// //              if(!mounted) return;
// //              Navigator.of(context).pop();
// //             },
// //             icon: Icon(Icons.check, color: Colors.white),
// //           ),
// //         ],
// //       ),
// //       body: Center(
// //         child: Consumer<AppImageProvider>(
// //           builder: (BuildContext context, value, Widget? child) {
// //             if (value.currentImage != null) {
// //               return
// //                 Screenshot(
// //                     controller: screenshotController,
// //                   child: ColorFiltered(
// //                       colorFilter: ColorFilter.matrix(currentFilter.matrix),
// //                     child: Image.memory(value.currentImage!),
// //                   ),
// //                 );
// //             }
// //             // If current image is null, show a progress indicator
// //             return Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           },
// //         ),
// //       ),
// //       bottomNavigationBar: Container(
// //       height: 70,
// //       width: double.infinity,
// //       color: Colors.black,
// //       child: SafeArea(
// //         child: SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child:Row(
// //
// //           )
// //
// //         ),
// //       ),
// //     ),
// //     );
// //   }
// // }
// //
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:projects/model/filter.dart'; // Import the Filter class
// import 'package:projects/widgets/homescreen.dart'; // Import HomeScreen if not already imported
// import 'package:projects/widgets/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';
//
// import '../helper/filters_s.dart';
//
// class Filter_Screen extends StatefulWidget {
//   const Filter_Screen({Key? key}) : super(key: key);
//
//   @override
//   State<Filter_Screen> createState() => _Filter_ScreenState();
// }
//
// class _Filter_ScreenState extends State<Filter_Screen> {
//   // late Filter currentFilter;
//   // late List<Filter> filters;
//   late AppImageProvider appImageProvider;
//   ScreenshotController screenshotController = ScreenshotController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize your filters list here using the Filters class
//     // filters = Filters().list();
//     // // Set initial filter
//     // currentFilter = filters[0];
//     // Get the appImageProvider once the context is available
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff212121),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "Filters",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//             );
//           },
//           icon: Icon(Icons.close, color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               Uint8List? byte = await screenshotController.capture();
//               appImageProvider.changeImage(byte!);
//               if (!mounted) return;
//               Navigator.of(context).pop();
//             },
//             icon: Icon(Icons.check, color: Colors.white),
//           ),
//         ],
//       ),
//       body:
//       Center(
//         child: Consumer<AppImageProvider>(
//           builder: (BuildContext context, value, Widget? child) {
//             if (value.currentImage != null) {
//               return Screenshot(
//                 controller: screenshotController,
//                 child: ColorFiltered(
//                         colorFilter: const ColorFilter.mode(
//                   Colors.blue,
//                   BlendMode.modulate,
//                 ),
//                     child: Image.memory(value.currentImage!)
//                 ),
//               );
//             }
//             // If current image is null, show a progress indicator
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 70,
//         width: double.infinity,
//         color: Colors.black,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//             _BottomButton(
//                 child: Text("purple",style: TextStyle(color: Colors.white),),
//                 onPressed: (){
//
//                 }
//             ),
//                 _BottomButton(
//
//                     onPressed: (){
//
//                     }, child: Text("abc"),
//                 ),
//                 _BottomButton(
//                     child: Text("filter",style: TextStyle(color: Colors.white),),
//                     onPressed: (){
//
//                     }
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _BottomButton({required child,required onPressed}){
//     return Consumer<AppImageProvider>(
//       builder: (BuildContext context, value, Widget? child,) {
//         return InkWell(
//           onTap: onPressed,
//           child: Column(
//             children: [
//               Image.memory(value.currentImage!,height: 40,width: 70,),
//               Text("data",style: TextStyle(color: Colors.white),),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }
//
// // class _FilterItem extends StatelessWidget {
// //   final Filter filter;
// //   final VoidCallback onPressed;
// //
// //   const _FilterItem({Key? key, required this.filter, required this.onPressed})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: onPressed,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
// //         child: Column(
// //           children: [
// //             Text(filter.filterName, style: TextStyle(color: Colors.white)),
// //             SizedBox(height: 5),
// //
// //             // You can add more widgets here to represent the filter visually
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//

import 'dart:typed_data';

import 'package:ai_remover_background/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../helper/filters.dart';
import '../helper/filters_s.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  late Filter currentFilter;
  late List<Filter> filters;

  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    filters = Filters().list();
    currentFilter = filters[0];
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const CloseButton(color: Colors.white,),
        centerTitle: true,
        title: const Text('Filter Screen',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () async {
                Uint8List? bytes = await screenshotController.capture();
                imageProvider.changeImage(bytes!);
                if(!mounted) return;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done,color: Colors.white,)
          )
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Screenshot(
                controller: screenshotController,
                child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(currentFilter.matrix),
                    child: Image.memory(value.currentImage!)
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        color: Colors.black,
        child: SafeArea(
            child: Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (BuildContext context, int index){
                      Filter filter = filters[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      currentFilter = filter;
                                    });
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.matrix(filter.matrix),
                                    child: Image.memory(value.currentImage!),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(filter.filterName,
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
            )
        ),
      ),
    );
  }
}