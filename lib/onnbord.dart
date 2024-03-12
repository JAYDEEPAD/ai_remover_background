// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OnboardingScreen(),
//     );
//   }
// }
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   List<Widget> _onboardingPages = [
//     OnboardingPage(
//       title: 'Welcome to MyApp',
//       description: 'This is a simple onboarding screen.',
//       imagePath: 'assets/images/img.png',
//     ),
//     OnboardingPage(
//       title: 'Explore Features',
//       description: 'Discover the amazing features of our app.',
//       imagePath: 'assets/images/img_1.png',
//     ),
//     OnboardingPage(
//       title: 'Get Started',
//       description: 'Ready to get started? Sign up now!',
//       imagePath: 'assets/images/img_2.png',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: _onboardingPages.length,
//         onPageChanged: (int page) {
//           setState(() {
//             _currentPage = page;
//           });
//         },
//         itemBuilder: (context, index) {
//           return _onboardingPages[index];
//         },
//       ),
//       bottomSheet: _currentPage == _onboardingPages.length - 1
//           ? ElevatedButton(
//         onPressed: () {
//           // Handle button press (e.g., navigate to the next screen)
//         },
//         style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[200])),
//         child: Text('Get Started',style: TextStyle(color: Colors.white),),
//       )
//           : null,
//     );
//   }
// }
//
// class OnboardingPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imagePath;
//
//   OnboardingPage({
//     required this.title,
//     required this.description,
//     required this.imagePath,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imagePath,
//             height: 350.0,
//           ),
//           SizedBox(height: 20.0),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:ai_remover_background/splash2.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';


import 'onbording.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _onboardingPages = [
    // OnboardingPage(
    //   title: 'Welcome to PhotoMe',
    //   description: 'Easy & Beautiful photo edit with us',
    //   imagePath: 'assets/image/img.png',
    // ),
    Splash2(),
    // OnboardingPage(
    //   title: 'Explore Features',
    //   description: 'Discover the amazing features of our app.',
    //   imagePath: 'assets/image/img_2.png',
    // ),
    OnBorading(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _onboardingPages[index];
                },
              ),
            ),
            PageViewDotIndicator(
              currentItem: _currentPage, count: _onboardingPages.length, unselectedColor: Colors.grey, selectedColor: Colors.black,
            ),
          ],
        ),
      ),
      // bottomSheet: _currentPage == _onboardingPages.length - 1
      //     ? ElevatedButton(
      //   onPressed: () {
      //     // Handle button press (e.g., navigate to the next screen)
      //   },
      //   style: ButtonStyle(
      //     backgroundColor:
      //     MaterialStatePropertyAll(Colors.deepPurple[200]),
      //   ),
      //   child: Text(
      //     'Get Started',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // )
      //     : null,
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 350.0,
          ),
          SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

