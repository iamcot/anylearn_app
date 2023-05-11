// import 'package:flutter/material.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/slide_object.dart';

// import '../screens/home/home_body.dart';

// class IntroScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => IntroScreenState();
// }

// class IntroScreenState extends State<IntroScreen> {
//   List<Slide> slides = [];

//   @override
//   void initState() {
//     super.initState();
//     slides.add(
//       new Slide(
//           backgroundImage: "assets/images/intro5.png",
//           backgroundOpacity: 0,
//           backgroundImageFit: BoxFit.fill),
//     );
//     // slides.add(
//     //   new Slide(
//     //       backgroundImage: "assets/images/intro6.jpg",
//     //       backgroundOpacity: 0,
//     //       backgroundImageFit: BoxFit.fill),
//     // );
//     slides.add(
//       new Slide(
//           backgroundImage: "assets/images/intro3.jpg",
//           backgroundOpacity: 0,
//           backgroundImageFit: BoxFit.fill),
//     );
//     // slides.add(
//     //   new Slide(
//     //       backgroundOpacity: 0,
//     //       backgroundImage: "assets/images/intro2.jpg",
//     //       backgroundImageFit: BoxFit.fill),
//     // );
//     slides.add(
//       new Slide(
//           backgroundImage: "assets/images/intro1.jpg",
//           backgroundOpacity: 0,
//           backgroundImageFit: BoxFit.fill),
//     );
//   }

//   void onDonePress() {
//     setState(() {
//       canShowPopup = true;
//     });
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: double.infinity,
//       height: double.infinity,
//       child: new IntroSlider(
//         slides: this.slides,
//         onDonePress: this.onDonePress,
//         onSkipPress: this.onDonePress,
//         renderNextBtn: Text(
//           "TIẾP",
//           style: TextStyle(color: Color.fromARGB(255, 220, 9, 167), fontWeight: FontWeight.bold),
//         ),
//         renderSkipBtn: Text(
//           "BỎ QUA",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         renderDoneBtn: Text(
//           "BẮT ĐẦU",
//           style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
