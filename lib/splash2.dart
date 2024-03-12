import 'package:flutter/material.dart';

class Splash2 extends StatelessWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 40,),
          Stack(
            children:
          [

            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 100,),
                Container(
                  height: 300,
                  width: 200,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 65,),
                Image.asset("assets/image/img_5.png"),
              ],
            ),
          ],
          ),
          SizedBox(height: 20,),
          Text('Welcome to PhotoMe',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,),),
          Text(
            "Edit your",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold

            ),
          ),
          Text(
            "Photos with",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold

            ),
          ),
          Text(
            "Advance tools",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 7,),
          Text(
            "Easy & Beautiful photo edit with us",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'CustomFont',
                 fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Easy & Beautiful photo edit with us Easy ",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
