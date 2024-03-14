// import 'package:flutter/material.dart';
// void main(){
//  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//      home: Profile()));
// }
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmpasswordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController creditController = TextEditingController();
//   String email = "", password = "", name = "";
//   String image_url = "";
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         body:
//         SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 SizedBox(
//                   height: 50,
//                 ),
//
//                 // CircleAvatar(
//                 //   backgroundImage: NetworkImage(
//                 //       'https://t4.ftcdn.net/jpg/05/86/91/55/240_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg',),
//                 //   radius: 40,
//                 // ),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: 23,),
//                     Text("Edit Profile",style: TextStyle(fontSize: 24),),
//                   ],
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Stack(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 'https://t4.ftcdn.net/jpg/05/86/91/55/240_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg'),
//                             radius: 50,
//                           ),
//                         ]),
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           hintText: "Name",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           fillColor: Colors.purple.withOpacity(0.1),
//                           filled: true,
//                          // prefixIcon: const Icon(Icons.person),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           hintText: "Last Name",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           fillColor: Colors.purple.withOpacity(0.1),
//                           filled: true,
//                          // prefixIcon: const Icon(Icons.email),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
//                             return 'Please enter a valid email address';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           hintText: "Mobile Number",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           fillColor: Colors.purple.withOpacity(0.1),
//                           filled: true,
//                         //  prefixIcon: const Icon(Icons.password),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a password';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: confirmpasswordController,
//                         decoration: InputDecoration(
//                           hintText: "Email",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           fillColor: Colors.purple.withOpacity(0.1),
//                           filled: true,
//                          // prefixIcon: const Icon(Icons.password),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password';
//                           } else if (value != passwordController.text) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           hintText: "credit",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide.none,
//                           ),
//                           fillColor: Colors.purple.withOpacity(0.1),
//                           filled: true,
//                           // prefixIcon: const Icon(Icons.person),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Builder(
//                     builder: (BuildContext builderContext) {
//                       return Container(
//                         padding: const EdgeInsets.only(top: 3, left: 3),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               // Navigator.push(
//                               //   builderContext,
//                               //   MaterialPageRoute(builder: (context) => OnBorading()),
//                               // );
//                             }
//                           },
//                           child: const Text(
//                             "Save changes",
//                             style: TextStyle(fontSize: 15, color: Colors.white),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: const StadiumBorder(),
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             backgroundColor: Colors.purple,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//       );
//   }
// }
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // This widget is the root of your application.
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController creditController = TextEditingController();

  String email = "", password = "", name = "";

  String image_url = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile ',
      home: Scaffold(
        body: ListView(
          children: <Widget>[

            Stack(
              children: [
                Positioned(
                    top: 30,
                    left: 20,

                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back))),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.shade300,
                        Colors.deepPurple.shade200
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 0.9],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                  'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Khushali Sarvaiya',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10,
                        right: 10), // Adjust the value to make it smaller
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 6, left: 10, right: 10),
                      height: 50,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the value for border radius
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10,
                        right: 10), // Adjust the value to make it smaller
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 6, left: 10, right: 10),
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the value for border radius
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10,
                        right: 10), // Adjust the value to make it smaller
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 6, left: 10, right: 10),
                      height: 50,
                      child: TextFormField(
                        controller: creditController,
                        decoration: InputDecoration(
                          hintText: "Credit",
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the value for border radius
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Builder(
                builder: (BuildContext builderContext) {
                  return Container(
                    padding: const EdgeInsets.only(top: 3, left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        // Navigator.push(
                        //   builderContext,
                        //   MaterialPageRoute(builder: (context) => OnBorading()),
                        // );
                        // }
                      },
                      child: const Text(
                        "Save changes",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        backgroundColor: Colors.purple[200],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
