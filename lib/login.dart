import 'package:ai_remover_background/signup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dashbord.dart';

  // void main()async{
  //   //runApp(LoginPage());
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   runApp(DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => LoginPage(),
  //   ),);
  // }
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String email = "";
  String password = "";
  String image_url = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(" no user found for that email")));
      } else if (e.code == 'wrong password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("wrong password provided by user"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 170,
                      width: 190,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                        ),
                        child: Image.asset(
                          'assets/image/login_pro.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: 27,),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(width: 28,),
                    Text("Enter your credential to login"),
                  ],
                ),
                // Column(
                //   children: [
                //     SizedBox(width: 5,),
                //     Text(
                //       "Welcome Back",
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black),
                //     ),
                //     Text("Enter your credential to login"),
                //   ],
                // ),
                SizedBox(height: 20,),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6,right: 6),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 6,right: 6),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.password),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Container(
                            padding: const EdgeInsets.only(top: 3,),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailController.text;
                                    password = passwordController.text;
                                  });
                                }
                                userLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                backgroundColor: Colors.purple,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>signup(name: '', email: '', imageUrl: '',)));
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(color: Colors.purple)),
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         signInWithGoogle().then((_) {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => signup(
                //                 name: nameController.text,
                //                 email: emailController.text,
                //                 imageUrl: image_url,
                //               ),
                //             ),
                //           );
                //         });
                //       },
                //       child: Image.network(
                //         'https://cdn-icons-png.flaticon.com/128/300/300221.png',
                //         height: 25,
                //         width: 25,
                //       ),
                //     ),
                //     SizedBox(width: 30),
                //     Image.network(
                //         'https://cdn-icons-png.flaticon.com/128/731/731985.png',
                //         height: 30,
                //         width: 30),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // signInWithGoogle() async {
  //   try {
  //     await GoogleSignIn().signOut();
  //     final GoogleSignIn _googleSignIn = GoogleSignIn();
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       setState(() {
  //         image_url = googleSignInAccount.photoUrl.toString();
  //         emailController.text = googleSignInAccount.email.toString();
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final List<Widget> _screens = [
//     Enhance(),
//     Ai(),
//     Filters(),
//     // CartPage(
//     //   product: Product(
//     //       id: 1,
//     //       name: 'Nike air max',
//     //       category: "Out of stock",
//     //       price: 180.0,
//     //       description: 'clean lines and timeless clean lines and timelessclean lines and timelessclean lines and timelessclean lines and timelessclean lines and timeless',
//     //       image: 'assets/images/1.png',
//     //       quantitiy: 1
//     //   ),
//     // ),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         // appBar: AppBar(
//         //
//         //   centerTitle: true,
//         //   leading:
//         //   Padding(
//         //     padding: const EdgeInsets.all(12.0),
//         //     child: CircleAvatar(child: Image(image: AssetImage('assets/drawer1.png'),height: 20,width: 20,)),
//         //   ),
//         //   // Container(
//         //   //   padding: EdgeInsets.all(13),
//         //   //   // height: 10,
//         //   //   //   width: 10,
//         //   //     child: CircleAvatar(
//         //   //       backgroundImage: AssetImage('assets/drawer1.png',),
//         //   //       radius: 3,
//         //   //     ),
//         //   //
//         //   // ),
//         //   title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
//         //   actions: [
//         //     IconButton(
//         //       onPressed: () {
//         //         Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),
//         //         ),);
//         //       },
//         //       icon: Padding(
//         //         padding: const EdgeInsets.all(4.0),
//         //         child: CircleAvatar(child: Image(image: AssetImage('assets/cart.png'),height: 20,width: 20,)),
//         //       ),
//         //     ),
//         //     IconButton(
//         //       onPressed: () {
//         //         Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),
//         //         ),);
//         //       },
//         //       icon: CircleAvatar(child: Image(image: AssetImage('assets/profile.png',),),radius: 15,),
//         //     ),
//         //   ],
//         // ),
//         body:
//         Center(
//           child: _screens.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.black,
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           unselectedItemColor: Colors.grey,
//           selectedItemColor: Colors.deepPurple[200],
//           onTap: _onItemTapped,
//           elevation: 5,
//           items: [
//             BottomNavigationBarItem(
//               backgroundColor: Colors.grey[200],
//               icon: Icon(Icons.home),
//               label: 'Enhance',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.grey[200],
//               icon: Icon(Icons.favorite),
//               label: 'AI Photos',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.grey[200],
//               icon: Icon(Icons.settings_overscan_sharp),
//               label: 'AI Filters',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class _EnhanceState extends State<Enhance> {
//   List products = [
//     {"Product_name":"AI Avatar Generator","price":"\$200" ,"image_path":'assets/images/ai1.png'},
//     {"Product_name":"AI Scene Generator","price":"\$200" ,"image_path":'assets/images/ai2.png'},
//     {"Product_name":"AI Anime Generator","price":"\$200" ,"image_path":'assets/images/ai3.png'},
//     {"Product_name":"AI Cartoonizer","price":"\$200" ,"image_path":'assets/images/ai4.png'},
//     {"Product_name":"AI Generator","price":"\$200" ,"image_path":'assets/images/ai5.png'},
//     {"Product_name":"AI Generator","price":"\$200" ,"image_path":'assets/images/ai6.png'},
//     // {"Product_name":"AI  Generator","price":"\$200" ,"image_path":'assets/images/1.png'},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return
//       SafeArea(
//         child: Scaffold(
//           // appBar: AppBar(
//           //   backgroundColor: Colors.grey[100],
//           //   centerTitle: true,
//           //   leading:
//           //   CircleAvatar(
//           //     radius: 10,
//           //    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/128/847/847969.png',),
//           //   ),
//           //   title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
//           //   actions: [
//           //     // IconButton(
//           //     //   onPressed: () {
//           //     //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),
//           //     //     // ),);
//           //     //   },
//           //     //   icon: Padding(
//           //     //     padding: const EdgeInsets.all(4.0),
//           //     //     child: CircleAvatar(child: Image(image: AssetImage('assets/cart.png'),height: 20,width: 20,)),
//           //     //   ),
//           //     // ),
//           //     // IconButton(
//           //     //   onPressed: ()
//           //     //   {
//           //     //
//           //     //       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
//           //     //
//           //     //     //  Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),),);
//           //     //   },
//           //     //   icon: CircleAvatar(child: Image(image: AssetImage('assets/profile.png',),),radius: 15,),
//           //     //
//           //     // ),
//           //     // Stack(
//           //     //     children: [
//           //     //       _image != null
//           //     //           ? CircleAvatar(
//           //     //         radius: 30,
//           //     //         backgroundImage: MemoryImage(_image!),
//           //     //       )
//           //     //           : CircleAvatar(
//           //     //         backgroundImage: NetworkImage(
//           //     //             'https://t4.ftcdn.net/jpg/05/86/91/55/240_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg'),
//           //     //         radius: 20,
//           //     //       ),
//           //     //     ]),
//           //     IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.black,),),
//           //     IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.black,),),
//           //     SizedBox(width: 15,),
//           //   ],
//           // ),
//           body:
//           SingleChildScrollView(
//             child: Column(
//                 children:
//                 [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 20,
//                       ),
//                       CircleAvatar(
//                         backgroundImage: NetworkImage('https://www.flaticon.com/free-icon/profile_3135715'),
//                       ),
//                       SizedBox(
//                         width: 18,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             "Welcome back",
//                             style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//
//                           Row(
//                             children: [
//                               SizedBox(width: 7,),
//                               Text("Khushali Sarvaiya"),
//                             ],
//                           ),
//                         ],
//                       ),
//                       // SizedBox(width: 30,),
//                       Spacer(),
//
//                       Row(
//                         children: [
//                           //this is for notification
//                           // Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3239/3239952.png',),
//                           //   height: 20,width: 20,),
//                           SizedBox(width: 10,),
//                           Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/2040/2040504.png',),
//                             height: 20,width: 20,),
//                           SizedBox(width: 10,),
//                           Stack(
//                               children:
//                               [
//                                 Material(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Container(
//                                     height: 30,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.deepPurple[200],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 7,
//                                   left: 4,
//                                   child: Image(
//                                     image: NetworkImage('https://cdn-icons-png.flaticon.com/128/6423/6423882.png',),
//                                     height: 15,width: 15,),
//                                 ),
//                                 Positioned(
//                                     top: 7,
//                                     right: 9,
//                                     child: Text("Pro",style: TextStyle(fontSize: 10),)),
//                               ]
//                           ),
//                           SizedBox(
//                             width: 22,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       SizedBox(
//                         height: 10,
//                       ),
//                       // Container(
//                       //   height: 150,
//                       //   width: MediaQuery.of(context).size.width * .9,
//                       //   decoration: BoxDecoration(
//                       //     gradient: LinearGradient(
//                       //       begin: Alignment.topLeft,
//                       //       end: Alignment.topRight,
//                       //       colors: [
//                       //         Color.fromRGBO(124, 87, 187, .5),
//                       //         Color.fromRGBO(128, 200, 226, 1)
//                       //       ],
//                       //     ),
//                       //     borderRadius: BorderRadius.all(Radius.circular(18)),
//                       //   ),
//                       //   child:
//                       //   Column(
//                       //     children: [
//                       //     //  Image.network('https://i.pinimg.com/564x/b4/02/e3/b402e36ca4d14f0a0f42cf26e74aec19.jpg'),
//                       //       SizedBox(height: 17,),
//                       //       Row(
//                       //         children: [
//                       //           SizedBox(width: 20,),
//                       //           Container(
//                       //             height: 120,
//                       //             width: 100,
//                       //             decoration: BoxDecoration(
//                       //               color: Colors.white.withOpacity(0.3),
//                       //               borderRadius: BorderRadius.all(Radius.circular(18)),
//                       //             ),
//                       //             child: Column(
//                       //               children: [
//                       //                 SizedBox(height: 10,),
//                       //                 Text("Get the special discount",style: TextStyle(fontSize: 7,color: Colors.white,fontWeight: FontWeight.w800),),
//                       //                 Text("50%\nOFF",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 35,color: Colors.white),),
//                       //                 //Text("OFF",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,color: Colors.white),),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //           SizedBox(width: 20,),
//                       //           //SizedBox(width: MediaQuery.of(context).size.width * .2,),
//                       //         ],
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       //
//                       // SizedBox(height: 5,),
//                       //
//                       //    Expanded(
//                       //        child: Padding(
//                       //      padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
//                       //      child: Grid(),
//                       //    )
//                       //    ),
//                       // SingleChildScrollView(
//                       //   child: Padding(
//                       //     padding:  EdgeInsets.only(left: 20,right: 20),
//                       //     child: SizedBox(
//                       //          height: 330,
//                       //         child: Expanded(
//                       //         //  flex: 20,
//                       //             child: Grid())),
//                       //   ),
//                       // ),
//                       //recently
//                       //recently
//                       Row(
//                         children: [
//                           SizedBox(width: 20,),
//                           Text("Rcently",style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 13,right: 13),
//                         child: SizedBox(
//                           height: 100,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: products.length,
//                               itemBuilder: (context,index){
//                                 return    Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: 50,
//                                     width: 80,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.asset(
//                                         '${products[index]['image_path']}',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//
//                       // albums
//
//                       Row(
//                         children: [
//                           SizedBox(width: 20,),
//                           Text("Albums",style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                           ),
//                           ),
//                           Spacer(),
//                           Text("See all",style: TextStyle(fontWeight: FontWeight.bold),),
//                           SizedBox(width: 20,),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         height: 100,
//                         width: MediaQuery.of(context).size.width * .9,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.topRight,
//                             colors: [
//                               Color.fromRGBO(124, 87, 187, .5),
//                               Color.fromRGBO(128, 200, 226, 1)
//                             ],
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(18)),
//                         ),
//                         child:
//                         Column(
//                           children: [
//                             //  Image.network('https://i.pinimg.com/564x/b4/02/e3/b402e36ca4d14f0a0f42cf26e74aec19.jpg'),
//                             SizedBox(height: 23,),
//                             Row(
//                               children: [
//                                 SizedBox(width: 10,),
//                                 Text("Animals",style: TextStyle(fontWeight: FontWeight.bold),),
//
//                               ],
//                             ),
//                             SizedBox(height: 10,),
//                             Row(
//                               children: [
//                                 SizedBox(width: 10,),
//                                 Text("50+ photos",style: TextStyle(fontWeight: FontWeight.bold),),
//
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Text("Rcently",style: TextStyle(
//                       //       fontWeight: FontWeight.bold,
//                       //       fontSize: 17,
//                       //     ),),
//                       //   ],
//                       // ),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       // SizedBox(
//                       //   height: 100,
//                       //   child: ListView.builder(
//                       //       scrollDirection: Axis.horizontal,
//                       //       itemCount: products.length,
//                       //       itemBuilder: (context,index){
//                       //         return    Padding(
//                       //           padding: const EdgeInsets.all(8.0),
//                       //           child: Container(
//                       //             height: 50,
//                       //             width: 80,
//                       //             child: ClipRRect(
//                       //               borderRadius: BorderRadius.circular(10),
//                       //               child: Image.asset(
//                       //                 '${products[index]['image_path']}',
//                       //                 fit: BoxFit.cover,
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         );
//                       //       }
//                       //   ),
//                       // ),
//                       SizedBox(height: 20,),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child:
//                         Row(
//                             children:
//                             [
//                               SizedBox(width: 20,),
//                               Material(
//                                 // elevation: 3.0,
//                                 borderRadius: BorderRadius.circular(10),
//                                 //  color: all? Colors.deepPurple[200] : Colors.white,
//                                 //  color: selectedCategoryProvider.selectedCategory == index
//                                 //      ? Colors.white
//                                 //      : Colors.white.withOpacity(0.4),
//                                 child: Container(
//                                   height: 65,
//                                   width: 65,
//                                   decoration: BoxDecoration(
//                                     color: Colors.deepPurple[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.asset('assets/images/all_pro.png',height: 1,width: 1,
//                                       // color:all? Colors.white : Colors.black ,
//                                       //  color: selectedCategoryProvider.selectedCategory == index
//                                       //     ? Colors.red
//                                       //   : Colors.grey
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 25,),
//                               Material(
//                                 // elevation: 3.0,
//                                 borderRadius: BorderRadius.circular(10),
//                                 //  color: all? Colors.deepPurple[200] : Colors.white,
//                                 //  color: selectedCategoryProvider.selectedCategory == index
//                                 //      ? Colors.white
//                                 //      : Colors.white.withOpacity(0.4),
//                                 child: Container(
//                                   height: 65,
//                                   width: 65,
//                                   decoration: BoxDecoration(
//                                     color: Colors.deepPurple[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.asset('assets/images/camera.png',height: 1,width: 1,
//                                       // color:all? Colors.white : Colors.black ,
//                                       //  color: selectedCategoryProvider.selectedCategory == index
//                                       //     ? Colors.red
//                                       //   : Colors.grey
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 25,),
//                               Material(
//                                 // elevation: 3.0,
//                                 borderRadius: BorderRadius.circular(10),
//                                 //  color: all? Colors.deepPurple[200] : Colors.white,
//                                 //  color: selectedCategoryProvider.selectedCategory == index
//                                 //      ? Colors.white
//                                 //      : Colors.white.withOpacity(0.4),
//                                 child: Container(
//                                   height: 65,
//                                   width: 65,
//                                   decoration: BoxDecoration(
//                                     color: Colors.deepPurple[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.asset('assets/images/download.png',height: 1,width: 1,
//                                       // color:all? Colors.white : Colors.black ,
//                                       //  color: selectedCategoryProvider.selectedCategory == index
//                                       //     ? Colors.red
//                                       //   : Colors.grey
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 25,),
//                               Material(
//                                 // elevation: 3.0,
//                                 borderRadius: BorderRadius.circular(10),
//                                 //  color: all? Colors.deepPurple[200] : Colors.white,
//                                 //  color: selectedCategoryProvider.selectedCategory == index
//                                 //      ? Colors.white
//                                 //      : Colors.white.withOpacity(0.4),
//                                 child: Container(
//                                   height: 65,
//                                   width: 65,
//                                   decoration: BoxDecoration(
//                                     color: Colors.deepPurple[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Image.asset('assets/images/files.png',height: 1,width: 1,
//                                       // color:all? Colors.white : Colors.black ,
//                                       //  color: selectedCategoryProvider.selectedCategory == index
//                                       //     ? Colors.red
//                                       //   : Colors.grey
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 20,),
//                             ]
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       //november
//                       Row(
//                         children: [
//                           SizedBox(width: 20,),
//                           Text("November , 2019",style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                           ),),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20,right: 20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai1.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai2.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai3.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Stack(
//                                   children:
//                                   [
//                                     Container(
//                                       height: 90,
//                                       width: 80,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Image.asset(
//                                           'assets/images/ai4.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),]
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       //April
//                       Row(
//                         children: [
//                           SizedBox(width: 20,),
//                           Text("April , 2019",style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                           ),),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20,right: 20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai1.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai2.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Container(
//                                 height: 90,
//                                 width: 80,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     'assets/images/ai3.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Stack(
//                                   children:
//                                   [
//                                     Container(
//                                       height: 90,
//                                       width: 80,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Image.asset(
//                                           'assets/images/ai4.png',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),]
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]
//             ),
//           ),
//         ),
//       );
//   }
// }
// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // Define a custom path to create a stylish clipped shape
//     // var path = Path();
//     // path.lineTo(size.width, 0);
//     // path.lineTo(size.width, size.height);
//     // path.lineTo(0, size.height);
//     // path.close();
//     // return path;
//    // Connect the last point to the starting point, closing the shape
//     var path = Path();
//
//     path.lineTo(size.width * 0.7, 0); // Draw a line to the top-right corner
//     path.quadraticBezierTo(size.width, 0, size.width, size.height * 0.3); // Curve to bottom-right corner
//     path.lineTo(size.width, size.height * 0.7); // Draw a line to the bottom-right corner
//     path.quadraticBezierTo(size.width, size.height, size.width * 0.7, size.height); // Curve to bottom-left corner
//     path.lineTo(size.width * 0.3, size.height); // Draw a line to the bottom-left corner, leaving 30% of the width straight
//     path.quadraticBezierTo(0, size.height, 0, size.height * 0.7); // Curve to top-left corner
//     path.lineTo(0, size.height * 0.3); // Draw a line to the top-left corner, leaving 30% of the height straight
//     path.close(); // Connect the last point to the starting point, closing the shape
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class ClipPathExample extends StatefulWidget {
//   const ClipPathExample({Key? key}) : super(key: key);
//
//   @override
//   State<ClipPathExample> createState() => _ClipPathExampleState();
// }
//
// class _ClipPathExampleState extends State<ClipPathExample> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ClipPath Example'),
//       ),
//       body: Center(
//         child:
//         ClipPath(
//           // Define a custom path to clip the child
//           clipper: MyClipper(),
//           child: Container(
//             width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.orange, Colors.white, Colors.green],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'ClipPath',
//                 style: TextStyle(
//                   color: const Color.fromARGB(255, 117, 95, 95),
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   String emailError = '';
//   String passwordError = '';
//   String email = "", password = "";
//   String image_url = "";
//   TextEditingController  nameController= TextEditingController();
//   TextEditingController  emailController= TextEditingController();
//   TextEditingController passwordController= TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   userLogin ()async{
//     try{
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//     }on FirebaseAuthException catch (e){
//       if(e.code=='user not found'){
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 backgroundColor: Colors.orangeAccent,
//                 content: Text(" no user found for that email")));
//       }else if(e.code=='wrong password'){
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.orangeAccent,
//             content: Text("wrong password provided by user"),),);
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       body:
//       SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(height: 40,),
//               Container(
//                 // width: MediaQuery.of(context).size.width,
//                 child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2q9Qi85tuW_DcgUVJoydTqScOc0yWf_4jUt14qZ_voNbtudv9mdcTA4R-Uxu6P5rIYAU&usqp=CAU',
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20,right: 20),
//                 child: Form(
//                   key: _formkey,
//                   child: Column(
//                     children: [
//                       // Container(
//                       //   padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.grey[300],
//                       //     borderRadius: BorderRadius.circular(20),
//                       //   ),
//                       //   child: TextFormField(
//                       //     validator: (value){
//                       //       if(value == null || value.isEmpty){
//                       //         return "enter a email";
//                       //       }
//                       //       return null;
//                       //     },
//                       //     onChanged: (value) {
//                       //       email = value;
//                       //     },
//                       //     controller: emailController,
//                       //     decoration: InputDecoration(
//                       //       border: InputBorder.none,
//                       //       hintText: "email",
//                       //     ),
//                       //   ),
//                       // ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               setState(() {
//                                 emailError = "please enter an email";
//                               });
//                               return null; // This will prevent the default error message from being displayed
//                             }
//                             setState(() {
//                               emailError = '';
//                             });
//                             return null;
//                           },
//                           onChanged: (value) {
//                             email = value;
//                           },
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "email",
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(width: 10,),
//                           Text(
//                             emailError,
//                             style: TextStyle(
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 25,),
//                       // Container(
//                       //   padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.grey[300],
//                       //     borderRadius: BorderRadius.circular(20),
//                       //   ),
//                       //   child: TextFormField(
//                       //     validator: (value){
//                       //       if(value == null || value.isEmpty){
//                       //         return "enter a password";
//                       //       }
//                       //       return null;
//                       //     },
//                       //     onChanged: (value) {
//                       //       password = value;
//                       //     },
//                       //     controller: passwordController,
//                       //     decoration: InputDecoration(
//                       //       border: InputBorder.none,
//                       //       hintText: "password",
//                       //     ),
//                       //   ),
//                       // ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               setState(() {
//                                 passwordError = "please enter a password";
//                               });
//                               return null; // This will prevent the default error message from being displayed
//                             }
//                             setState(() {
//                               passwordError = '';
//                             });
//                             return null;
//                           },
//                           onChanged: (value) {
//                             password = value;
//                           },
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Password",
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(width: 10,),
//                           Text(
//                             passwordError,
//                             style: TextStyle(
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30,),
//                       GestureDetector(
//                         onTap: (){
//                           if(_formkey.currentState!.validate()){
//                             setState(() {
//                               email = emailController.text;
//                               password= passwordController.text;
//                             });
//                           }
//                           userLogin();
//                         },
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
//                           decoration: BoxDecoration(
//                             color: Colors.deepPurple[200],
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Center(child: Text("Sign In",style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                           ),)),
//
//                         ),
//                       ),
//                       SizedBox(height: 10,),
//                       SizedBox(height: 10,),
//                       TextButton(onPressed: (){
//                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_password()));
//                       }, child: Text("Forgot Password ?"),
//                       ),
//                       SizedBox(height: 10,),
//                       Text("OR"),
//                       SizedBox(height: 10,),
//                       Row(mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             // onTap: (){
//                             //  // AuthService().signInWithGoogle(context);
//                             //   signInWithGoogle();
//                             //   Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //       builder: (context) => Signup_Page(
//                             //         name: nameController.text,
//                             //         email: emailController.text,
//                             //         imageUrl: image_url,
//                             //       ),
//                             //     ),
//                             //   );
//                             // },
//                             onTap: () {
//                               signInWithGoogle().then((_) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => signup(
//                                       name: nameController.text,
//                                       email: emailController.text,
//                                       imageUrl: image_url,
//                                     ),
//                                   ),
//                                 );
//                               });
//                             },
//                             child: Image.network('https://cdn-icons-png.flaticon.com/128/300/300221.png',height: 30,width: 30,),
//                           ),
//                           SizedBox(width: 30,),
//                           Image.network('https://cdn-icons-png.flaticon.com/128/731/731985.png',height: 35,width: 35,),
//
//                         ],
//                       ),
//                       SizedBox(height: 10,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 10,),
//                           Text("Don't have account ?"),
//                           // SizedBox(width: 5,),
//                           TextButton(onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>signup(name: '', email: email, imageUrl:''),));
//                           }, child: Text("Sign Up "),
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   signInWithGoogle() async {
//     try {
//       await GoogleSignIn().signOut();
//       final GoogleSignIn _googleSignIn = GoogleSignIn();
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         setState(() {
//           image_url = googleSignInAccount.photoUrl.toString();
//           emailController.text = googleSignInAccount.email.toString();
//         });
//       }
//     } catch (error) {
//       print(error.toString());
//     }
//   }
// }
