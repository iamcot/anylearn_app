import 'package:anylearn/screens/home/home_body.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        backgroundImage: "assets/images/intro3.jpg",
        backgroundOpacity: 0,
      ),
    );
    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage: "assets/images/intro2.jpg",
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/images/intro1.jpg",
        backgroundOpacity: 0,
      ),
    );
    slides.add(new Slide(
      backgroundImage: "assets/images/FlyerT.jpg",
      backgroundOpacity: 0,
      
      backgroundImageFit: BoxFit.fitWidth,
    ));
    slides.add(
      new Slide(
        backgroundImage: "assets/images/FlyerS.jpg",
        backgroundOpacity: 0,
        backgroundImageFit: BoxFit.fitHeight,
      ),
    );
  }

  void onDonePress() {
    setState(() {
      canShowPopup = true;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: new IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
        onSkipPress: this.onDonePress,
        renderNextBtn: Text(
          "TIẾP",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        renderSkipBtn: Text(
          "BỎ QUA",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        renderDoneBtn: Text(
          "BẮT ĐẦU",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
