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
  bool _userHasPurchasedPlan = true;
  @override
  void initState() {
    super.initState();
    _checkUserPlanPurchase();
  }
  Future<void> _checkUserPlanPurchase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      bool hasPurchasedPlan = snapshot.exists && snapshot.data()?['premium_plan_purchased'] == true;
      setState(() {
        _userHasPurchasedPlan = hasPurchasedPlan;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        centerTitle: true,
        title: Text("Plan Details"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/image/img_24.png',width: double.infinity,height: 200,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumPlanScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[200]),
                  ),
                  child: Text("Upgrade the plan",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                ),
              ),
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