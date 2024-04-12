import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'as ui;
import 'dart:ui';


import 'package:ai_remover_background/home_screen.dart';
import 'package:ai_remover_background/provider.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropScreen extends StatefulWidget {
  const CropScreen({super.key});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  late AppImageProvider appImageProvider;
  @override
  void initState() {

    super.initState();
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Crop Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            icon: Icon(Icons.close,color: Colors.white,)),
        actions: [
          IconButton(onPressed: () async {
            ui.Image bitmap = await controller.croppedBitmap();
            ByteData? data = await bitmap.toByteData(format: ImageByteFormat.png);
            Uint8List bytes = data!.buffer.asUint8List();
            appImageProvider.changeImage(bytes);
            if(!mounted) return;
            Navigator.of(context).pop();

          }, icon: Icon(Icons.check,color: Colors.white,)),
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.currentImage != null) {
                return CropImage(controller: controller,
                  image: Image.memory(value.currentImage!),
                  paddingSize: 25.0,
                  alwaysMove: true,
                );

              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
            Row(
              children: [
                _BottomButton(
                    child: Icon(Icons.rotate_90_degrees_cw_outlined,color: Colors.white,),
                    onPressed: (){
                      controller.rotateRight();
                    }),
                _BottomButton(
                    child: Icon(Icons.rotate_90_degrees_ccw_outlined,color: Colors.white,),
                    onPressed: (){
                      controller.rotateLeft();
                    }),
                Container(
                  color: Colors.white,
                  height: 45,
                  width: 2,
                ),
                _BottomButton(
                    child: Text("Free",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = null;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),
                _BottomButton(
                    child: Text("1:1",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = 1;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),
                _BottomButton(
                    child: Text("2:1",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = 2;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),
                _BottomButton(
                    child: Text("1:2",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = 1/2;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),
                _BottomButton(
                    child: Text("4:3",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = 4/3;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),  _BottomButton(
                    child: Text("16:9",style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      controller.aspectRatio = 19/6;
                      controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _BottomButton({required child,required onPressed}){
    return  InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}