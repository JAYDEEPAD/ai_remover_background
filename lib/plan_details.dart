// import 'package:flutter/material.dart';
//
// import '../screen/premiumplan_screen.dart';
//
// class Plan_Details extends StatefulWidget {
//   final PlanDetailsArguments arguments;
//   const Plan_Details({Key? key, required this.arguments}) : super(key: key);
//
//
//   @override
//   State<Plan_Details> createState() => _Plan_DetailsState();
// }
//
// class _Plan_DetailsState extends State<Plan_Details> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple[200],
//         centerTitle: true,
//         title: Text("Plan Details",
//           style: TextStyle(
//
//         ),),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             title: Text("Plan Name: ${widget.arguments.planName}"),
//           ),
//           ListTile(
//             title: Text("Duration: ${widget.arguments.duration}"),
//           ),
//           ListTile(
//             title: Text("Price: ${widget.arguments.price}"),
//           ),
//
//
//           Row(
//             children: [
//               SizedBox(width: 20,),
//               ElevatedButton(
//                 onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumPlanScreen()));
//                 },
//                 child: Text(
//                   "Upgrade the plan",
//                   style: TextStyle(),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//
//     );
//   }
// }
//
// class PlanDetailsArguments {
//   final String planName;
//   final String duration;
//   final double price;
//
//   PlanDetailsArguments({
//     required this.planName,
//     required this.duration,
//     required this.price,
//   });
// }

import 'package:ai_remover_background/premiumplan_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Plan_Details extends StatefulWidget {
  final PlanDetailsArguments arguments;
  const Plan_Details({Key? key, required this.arguments}) : super(key: key);

  @override
  State<Plan_Details> createState() => _Plan_DetailsState();
}

class _Plan_DetailsState extends State<Plan_Details> {
  bool _userHasPurchasedPlan = false;

  @override
  void initState() {
    super.initState();
    _checkUserPlanPurchase();
  }

  Future<void> _checkUserPlanPurchase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      bool hasPurchasedPlan =
          snapshot.exists && snapshot.data()?['premium'] == true;
      setState(() {
        _userHasPurchasedPlan = hasPurchasedPlan;
      });
    }
  }

  Future<void> _upgradePlan(BuildContext context, String planDuration) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get the price of the plan (assuming it's stored in widget.arguments.price)
      double price = widget.arguments.price;

      // Calculate the plan duration in months or years based on user selection
      int months = 0;
      if (planDuration == '1 month') {
        months = 1;
      } else if (planDuration == '1 year') {
        months = 12;
      }

      // Calculate the plan end date
      DateTime planEndDate = DateTime.now().add(Duration(days: 30 * months));

      // Update user's premium plan purchase status along with price and plan duration
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'premium': true,
        'plan_duration': planDuration, // Store plan duration
        'plan_price': price, // Store plan price
        'plan_end_date': planEndDate, // Store plan end date
      });
      setState(() {
        _userHasPurchasedPlan = true;
      });

      // Navigate to the upgrade screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PremiumPlanScreen()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        centerTitle: true,
        title: Text("Plan Details"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/image/img_24.png',
            width: double.infinity,
            height: 200,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text("Plan Name:  ${widget.arguments.planName}"),
              ),
              ListTile(
                title: Text("Duration:  ${widget.arguments.duration}"),
              ),
              ListTile(
                title: Text("Price:  ${widget.arguments.price}"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if(_userHasPurchasedPlan)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      _upgradePlan(context, widget.arguments.duration);
                    },
                        style:ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[200]),
                        ),
                        child: Text("Upgrade Plan",style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                        ),),),
            
                ],
              ),
        ],
      ),
    );
  }
}

class PlanDetailsArguments {
  final String planName;
  final String duration;
  final double price;

  PlanDetailsArguments({
    required this.planName,
    required this.duration,
    required this.price,
  });
}