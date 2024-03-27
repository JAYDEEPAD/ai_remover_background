import 'package:ai_remover_background/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  var _razorpay = Razorpay();

  void initState(){
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  void dispose(){
    _razorpay.clear();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
          body:
          // Center(
          //   child: ElevatedButton(onPressed: (){
          //     _logout();
          //   }, child: Text("LogOut")),
          // ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:  Container(
                          //  height: 45,
                          // width: 45,
                          // decoration: BoxDecoration(
                          //   color: Colors.deepPurple[200],
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: Image.asset('assets/image/img_17.png',height: 30,width: 30,),
                        ),
                      ),
                      //  Icon(Icons.cancel,size: 30,),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15,),
                      Text("Settings",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[200],
                          fontSize: 25
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child:
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                          children:
                          [
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Image.asset('assets/image/img_18.png',height: 120,width: 120,),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .28,
                              width: MediaQuery.of(context).size.width * .99,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromRGBO(124, 87, 187, .5),
                                    Color.fromRGBO(128, 200, 226, 1)
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      SizedBox(width: 25,),
                                      Text("Photo Me Pro",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 30,),
                                      Text("Unlimited saves",
                                        style: TextStyle(


                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 30,),
                                      Text("Multiple Results",
                                        style: TextStyle(


                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          _logout();

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child:
                                          Material(
                                            elevation: 4,
                                            borderRadius: BorderRadius.circular(35),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * .06,
                                              width: MediaQuery.of(context).size.width * .5,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 55,),
                                                      Text("Try Pro Now",style: TextStyle(
                                                          fontWeight: FontWeight.bold,

                                                          color: Colors.white
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),]
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .12,
                        width: MediaQuery.of(context).size.width * .99,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(

                          children: [
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text("Privacy",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child:
                    GestureDetector(
                      onTap: (){
                        var options = {
                          'key': 'rzp_test_RsqV5b0NEAwbWT',
                          'amount': 1 * 100, //in the smallest currency sub-unit.
                          'name': 'Acme Corp.',
                          'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                          'description': 'Fine T-Shirt',
                          'timeout': 60, // in seconds
                        };
                        _razorpay.open(options);
                      },
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .12,
                          width: MediaQuery.of(context).size.width * .99,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text("Payment",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child:
                    Material(
                      borderRadius: BorderRadius.circular(25),
                      elevation: 4,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * .99,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 25,),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text("Settings",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      _logout();

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .6,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 70,),
                                  Text("Log Out",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}