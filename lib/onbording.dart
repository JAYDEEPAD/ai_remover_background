
import 'package:ai_remover_background/wrap.dart';
import 'package:flutter/material.dart';


import 'login.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       tools: [
//         ...DevicePreview.defaultTools,
//       ],
//       builder: (context) => OnBorading(),
//     ),
//   );
//   // runApp(MaterialApp(
//   //   debugShowCheckedModeBanner: false,
//   //     home: OnBorading()));
// }

class OnBorading extends StatefulWidget {
  const OnBorading({super.key});

  @override
  State<OnBorading> createState() => _OnBoradingState();
}

class _OnBoradingState extends State<OnBorading> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    print(h);
    print(w);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Stack(children: [
                Row(
                  children: [
                    // SizedBox(width: 20,),
                    Container(
                      height: 200,
                      width: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/image/img_1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 200,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/image/img_1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: 90,
              ),
              Text(
                "Your photos will reach",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  //  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              Text(
                "a unique dimension",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    //  width: MediaQuery.of(context).size.width * .2,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Material(
                      elevation: 5.0,
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .8,
                        // width: MediaQuery.of(context).size.width * .55,
                        decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Color(0x3F000000),
                            //     blurRadius: 4,
                            //     offset: Offset(0, 4),
                            //     spreadRadius: 0,
                            //   ),
                            // ]
                            ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 17),
                              child: Center(
                                  child: Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "We use cookies to provide you with better experience.\n By "
                    "continuing, you acknowledge that you have read,\n understood and agreed our Cookie Policy.",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 130,
            right: (MediaQuery.of(context).size.width < 480.0) ? 90 : 150,
           // right: (MediaQuery.of(context).size.width <= 411.0) ? 90 : 130,
          //  right: (MediaQuery.of(context).size.width == 480.0) ? 150 : 100,
         //  right: 150,
           // right: 100,
            child:  Container(
            height: 200,
            width: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/image/img_1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
