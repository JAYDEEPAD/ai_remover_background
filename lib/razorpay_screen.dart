import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main(){
  runApp(MaterialApp(home: RazorPayScreen(),debugShowCheckedModeBanner: false,));
}


class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({super.key});

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  late Razorpay _razorpay;
  TextEditingController _amtController=TextEditingController();



  void openCheckout( int amount){
    int amountInPaise = amount * 100;
    var options={
      'key' : 'rzp_test_1D5mm0lF5G5ag',
      'amount': amountInPaise,
      'name' : 'Geek for Geeks',
      'prefill' : {'contact': '9033456527','email':'jdpadvani@gmail.com'},
      'external' :{
        'wallets':['paytm']
      }
    };

    try{
      _razorpay.open(options);
    }catch(e){
      debugPrint('Error : e');
    }

  }

  void handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "Payment Successfull" + response.paymentId!, toastLength: Toast.LENGTH_SHORT);
  }
  void handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "Payment Failed" + response.message!, toastLength: Toast.LENGTH_SHORT);
  }
  void handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "External Wallet" + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            SizedBox(height: 10,),
            Text("Welcome to Razorpay Payment Gateway Integration ", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: Colors.white,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter Amount to be Paid',
                labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                border: OutlineInputBorder(
                  borderSide:BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15,
                ),
              ),
              controller: _amtController,
              validator: (value){
                if(value == null  || value.isEmpty){
                    return "Please Enter Amount to be paid";
                }
                return null;
              },),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              if(_amtController.text.toString().isNotEmpty){
                setState(() {
                  int amount=int.parse(_amtController.text.toString());
                  openCheckout(amount);
                });
              }
            }, child: Padding(padding: EdgeInsets.all(8.0),
                 child: Text('Make Payment'),
            ), style: ElevatedButton.styleFrom(primary: Colors.green),)
          ],
        ),
      ),

    );
  }
}

