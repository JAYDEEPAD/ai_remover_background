import 'dart:typed_data';

import 'package:ai_remover_background/helper/fonts.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:text_editor/text_editor.dart';

import 'home_screen.dart';

class Text_Screen extends StatefulWidget {

  @override
  State<Text_Screen> createState() => _Text_ScreenState();
}

class _Text_ScreenState extends State<Text_Screen> {
  bool showeditor = false;
  late AppImageProvider appImageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }
  LindiController controller = LindiController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xff212121),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Text Screen",
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
                    Uint8List? byte = await controller.saveAsUint8List();
                    appImageProvider.changeImage(byte!);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.check, color: Colors.white)),
            ],
          ),
          body: Center(
            child: Consumer<AppImageProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.currentImage != null) {
                  return
                   LindiStickerWidget(
                     controller: controller,
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
            height: 60,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: TextButton(
                onPressed: (){
                  setState(() {
                    showeditor = true;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.add,color: Colors.white,),
                    SizedBox(
                      width: 20,
                    ),
                   Text("add Text",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        ),
        if(showeditor)
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.75),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextEditor(
                fonts: Fonts().list(),
                // paletteColors: colors,
                // text: text,
                maxFontSize: 70,
                minFontSize: 10,
                textStyle: TextStyle(
                  color: Colors.white
                ),
               // textAlingment: textAlign,
                onEditCompleted: (style, align, text) {
                  setState(() {
                    showeditor= false;
                    if(text.isNotEmpty)
                      controller.addWidget(
                        Text(text,
                          textAlign: align,
                          style: style,
                        ),);
                  });

                },
              ),
            ),
          ),
        ),
      ],
    );
  }
  // Widget _BottomButton(IconData icon, String title,
  //     {Color? color, required onPressed}) {
  //   return InkWell(
  //     onTap: onPressed,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //       child: Column(
  //         children: [
  //           Icon(
  //             icon,
  //             color: color ?? Colors.white,
  //           ),
  //           Text(
  //             title,
  //             style: TextStyle(color: color ?? Colors.white70),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
