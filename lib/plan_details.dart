import 'package:flutter/material.dart';

class Plan_Details extends StatefulWidget {
  final PlanDetailsArguments arguments;
  const Plan_Details({Key? key, required this.arguments}) : super(key: key);


  @override
  State<Plan_Details> createState() => _Plan_DetailsState();
}

class _Plan_DetailsState extends State<Plan_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        centerTitle: true,
        title: Text("Plan Details",
          style: TextStyle(

        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Plan Name: ${widget.arguments.planName}"),
          ),
          ListTile(
            title: Text("Duration: ${widget.arguments.duration}"),
          ),
          ListTile(
            title: Text("Price: ${widget.arguments.price}"),
          ),
          // Add more ListTile widgets for additional details if needed
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