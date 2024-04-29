// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../widgets/plan_details.dart';
// import 'enhance.dart';
//
// class PremiumPlanScreen extends StatefulWidget {
//   @override
//   State<PremiumPlanScreen> createState() => _PremiumPlanScreenState();
// }
// class _PremiumPlanScreenState extends State<PremiumPlanScreen> {
//   var _razorpay = Razorpay();
//   String _selectedDuration = "";
//   bool _planPurchased = false; // Track if plan is purchased
//   String _purchasedPlanName = ""; // Store purchased plan name
//   String _purchasedDuration = ""; // Store purchased duration
//   double _purchasedPrice = 0; // Track selected duration
//
//   void initState() {
//     super.initState();
//     _fetchPurchasedPlanDetails();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//   void _fetchPurchasedPlanDetails() {
//     // Replace the following lines with your logic to fetch plan details from wherever it's stored
//     // For example, you might fetch it from SharedPreferences, database, etc.
//     // For demonstration, I'm setting dummy values here
//     _planPurchased = true;
//     _purchasedPlanName = "Photo Me Pro";
//     _purchasedDuration = "1 month";
//     _purchasedPrice = 10.0;
//   }
//   // void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   //
//   //   Fluttertoast.showToast(
//   //     msg: "Payment successful",
//   //     toastLength: Toast.LENGTH_SHORT,
//   //     gravity: ToastGravity.BOTTOM,
//   //     backgroundColor: Colors.green,
//   //     textColor: Colors.white,
//   //   );
//   // }
//   // void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   //   Fluttertoast.showToast(
//   //     msg: "Payment successful",
//   //     toastLength: Toast.LENGTH_SHORT,
//   //     gravity: ToastGravity.BOTTOM,
//   //     backgroundColor: Colors.green,
//   //     textColor: Colors.white,
//   //   );
//   //   // Set result to indicate premium plan purchased
//   //   Navigator.pop(context, true);
//   // }
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//       msg: "Payment successful",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//     );
//
//     // Navigate to Plan_Details screen with the purchased plan details
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Plan_Details(
//           arguments: PlanDetailsArguments(
//             planName: "Photo Me Pro", // Example plan name
//             duration: "1 month", // Example duration
//             price: 10, // Example price
//           ),
//         ),
//       ),
//     ).then((value) {
//       // Set result to indicate premium plan purchased
//       Navigator.pop(context, true);
//     });
//   }
//
//
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//
//     Fluttertoast.showToast(
//       msg: "Payment failed. Please try again later.",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//
//     Fluttertoast.showToast(
//       msg: "Payment via external wallet (${response.walletName}) selected.",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.blue,
//       textColor: Colors.white,
//     );
//   }
//
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _processPayment(double amount) {
//     var options = {
//       'key': 'rzp_test_RsqV5b0NEAwbWT', // Replace with your actual Razorpay key
//       'amount': (amount * 100).toInt(), // Amount should be in smallest currency unit (e.g., paise for INR)
//       'name': 'abc', // Name of the payment recipient
//       'description': 'Pay For Premium Plan', // Description of the payment
//       'prefill': {
//         'contact': '1234567890', // Replace with user's phone number
//         'email': 'abc@gmail.com', // Replace with user's email address
//       },
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.close, color: Colors.black),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Premium Plan",
//           style: TextStyle(
//             fontFamily: 'OpenSans',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 9,right: 9),
//                 child:
//                 Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(30),
//                   child: Stack(
//                       children:
//                       [
//                         Positioned(
//                           top: 20,
//                           right: 20,
//                           child: Image.asset(
//                             'assets/images/img_18.png',
//                             height: 120,width: 120,),
//                         ),
//                         Container(
//                           height: MediaQuery.of(context).size.height * .26,
//                           width: MediaQuery.of(context).size.width * .99,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(30),
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.topRight,
//                               colors: [
//                                 Color.fromRGBO(124, 87, 187, .5),
//                                 Color.fromRGBO(128, 200, 226, 1)
//                               ],
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(height: 20,),
//                               Row(
//                                 children: [
//                                   SizedBox(width: 25,),
//                                   Text("Photo Me Pro",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10,),
//                               Row(
//                                 children: [
//                                   SizedBox(width: 30,),
//                                   Text("Unlimited saves",
//                                     style: TextStyle(
//
//
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 12,),
//                               Row(
//                                 children: [
//                                   SizedBox(width: 30,),
//                                   Text("Multiple Results",
//                                     style: TextStyle(
//
//
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 12,),
//                               Row(
//                                 children: [
//                                   SizedBox(width: 30,),
//                                   Text("Export high quality image",
//                                     style: TextStyle(
//
//
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),]
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               // Widget for 1 month plan
//               Padding(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedDuration = "1 month";
//                     });
//                   },
//                   child: Material(
//                     elevation: 4,
//                     borderRadius: BorderRadius.circular(25),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * .11,
//                       width: MediaQuery.of(context).size.width * .99,
//                       decoration: BoxDecoration(
//                         color: _selectedDuration == "1 month" ? Colors.deepPurple[200] : Colors.white, // Change color when selected
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 30,),
//                           Row(
//                             children: [
//                               SizedBox(width: 20,),
//                               Text("1 month",style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: _selectedDuration == "1 month" ? Colors.white : Colors.black, // Change text color when selected
//                               ),),
//                               Spacer(),
//                               Text(" ₹ 10/Month", style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: _selectedDuration == "1 month" ? Colors.white : Colors.black, // Change text color when selected
//                               ),),
//                               SizedBox(width: 20,),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               // Widget for 1 year plan
//               Padding(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedDuration = "1 year";
//                     });
//                   },
//                   child: Material(
//                     elevation: 4,
//                     borderRadius: BorderRadius.circular(25),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * .11,
//                       width: MediaQuery.of(context).size.width * .99,
//                       decoration: BoxDecoration(
//                         color: _selectedDuration == "1 year" ? Colors.deepPurple[200] : Colors.white, // Change color when selected
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 30,),
//                           Row(
//                             children: [
//                               SizedBox(width: 20,),
//                               Text("1 year",style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: _selectedDuration == "1 year" ? Colors.white : Colors.black, // Change text color when selected
//                               ),),
//                               Spacer(),
//                               Text(" ₹ 100/year ",style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: _selectedDuration == "1 year" ? Colors.white : Colors.black, // Change text color when selected
//                               ),),
//                               SizedBox(width: 20,),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               //cancel anytime
//               Text(
//                 "Cancel anytime",
//                 style: TextStyle(fontSize: 16,color: Colors.grey),
//               ),
//               SizedBox(height: 15,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20,right: 20),
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_selectedDuration.isNotEmpty) {
//                       // Proceed with selected duration
//                       if (_selectedDuration == "1 month") {
//                         _processPayment(10); // Call _processPayment with 1 month subscription amount
//                       } else if (_selectedDuration == "1 year") {
//                         _processPayment(100); // Call _processPayment with 1 year subscription amount
//                       }
//                     } else {
//                       // Show a SnackBar if no duration is selected
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please select a plan.'),
//                           duration: Duration(seconds: 2),
//                         ),
//                       );
//                     }
//                   },
//                   child: Material(
//                     elevation: 3,
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       height: 39,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple[300],
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "continue",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 19,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15,),
//               Row(
//                 children: [
//
//                   SizedBox(width: 25,),
//                   Text("Terms of use",style: TextStyle(fontSize: 16,color: Colors.grey),),
//                   SizedBox(width: 5,),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 1),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           left: BorderSide(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                         ),
//                       ),
//
//                     ),
//                   ),
//                   Text("Privacy Policy",style: TextStyle(fontSize: 16,color: Colors.grey),),
//                   SizedBox(width: 5,),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 1),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           left: BorderSide(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                         ),
//                       ),
//
//                     ),
//                   ),
//                   Text("Restore",style: TextStyle(fontSize: 16,color: Colors.grey),),
//                   SizedBox(width: 25,),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
import 'package:ai_remover_background/plan_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PremiumPlanScreen extends StatefulWidget {
  @override
  _PremiumPlanScreenState createState() => _PremiumPlanScreenState();
}

class _PremiumPlanScreenState extends State<PremiumPlanScreen> {
  var _razorpay = Razorpay();
  String _selectedDuration = "";
  bool _planPurchased = false;
  String _purchasedPlanName = "";
  String _purchasedDuration = "";
  double _purchasedPrice = 0;

  @override
  void initState() {
    super.initState();
    _fetchPurchasedPlanDetails();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _fetchPurchasedPlanDetails() {
    // Fetch plan details from wherever it's stored
    // For demonstration, setting dummy values here
    _planPurchased = true;
    _purchasedPlanName = "Photo Me Pro";
    _purchasedDuration = "1 month";
    _purchasedPrice = 10.0;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );

    // Navigate to Plan_Details screen with the purchased plan details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Plan_Details(
          arguments: PlanDetailsArguments(
            planName: "Photo Me Pro", // Example plan name
            duration: "1 year", // Example duration
            price: 100, // Example price
          ),
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment failed. Please try again later.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "Payment via external wallet (${response.walletName}) selected.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  void _processPayment(double amount) {
    var options = {
      'key': 'rzp_test_RsqV5b0NEAwbWT', // Replace with your actual Razorpay key
      'amount': (amount * 100).toInt(), // Amount should be in smallest currency unit (e.g., paise for INR)
      'name': 'abc', // Name of the payment recipient
      'description': 'Pay For Premium Plan', // Description of the payment
      'prefill': {
        'contact': '1234567890', // Replace with user's phone number
        'email': 'abc@gmail.com', // Replace with user's email address
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "Premium Plan",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 9),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Image.asset(
                          'assets/image/img_18.png',
                          height: 120,
                          width: 120,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .26,
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
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Text(
                                  "Photo Me Pro",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Text(
                                  "Unlimited saves",
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Text(
                                  "Multiple Results",
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Text(
                                  "Export high quality image",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Widget for 1 month plan
              // Widget for 1 month plan
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDuration = "1 month";
                    });
                  },
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .11,
                      width: MediaQuery.of(context).size.width * .99,
                      decoration: BoxDecoration(
                        color: _selectedDuration == "1 month" ? Colors.deepPurple[200] : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                "1 month",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _selectedDuration == "1 month" ? Colors.white : Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                " ₹ 10/Month",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _selectedDuration == "1 month" ? Colors.white : Colors.black,
                                ),
                              ),
                              /*if (_selectedDuration == "1 month" && _planPurchased && _purchasedDuration == "1 month")*/
                                SizedBox(width: 10),
                              /*if (_selectedDuration == "1 month" && _planPurchased && _purchasedDuration == "1 month")
                                Text(
                                  "Purchased",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),*/
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // Widget for 1 year plan
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDuration = "1 year";
                    });
                  },
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .11,
                      width: MediaQuery.of(context).size.width * .99,
                      decoration: BoxDecoration(
                        color: _selectedDuration == "1 year" ? Colors.deepPurple[200] : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                "1 year",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _selectedDuration == "1 year" ? Colors.white : Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                " ₹ 100/year ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: _selectedDuration == "1 year" ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Cancel anytime
              Text(
                "Cancel anytime",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    if (_selectedDuration.isNotEmpty) {
                      // Proceed with selected duration
                      if (_selectedDuration == "1 month") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Plan_Details(
                              arguments: PlanDetailsArguments(
                                planName: "Photo Me Pro", // Example plan name
                                duration: "1 month", // Example duration
                                price: 10, // Example price
                              ),
                            ),
                          ),
                        );
                      } else if (_selectedDuration == "1 year") {
                        _processPayment(100); // Call _processPayment with 1 year subscription amount
                      }
                    } else {
                      // Show a SnackBar if no duration is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a plan.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 39,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 25),
                  Text(
                    "Terms of use",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Restore",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}