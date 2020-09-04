import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController animationcontroller;
  Animation degreeOneTranslationAnimation,degreeTwoTranslationAnimation,degreeThreeTranslationAnimation;
  Animation rotationAnimation;
  Animation rotationforAdd;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degreeOneTranslationAnimation =
        TweenSequence([
          TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0,end: 1.2),weight: 75.0),
          TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2,end: 1.0),weight: 25.0),
        ]).animate(animationcontroller);
    degreeTwoTranslationAnimation =
        TweenSequence([
          TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0,end: 1.4),weight: 55.0),
          TweenSequenceItem<double>(tween: Tween<double>(begin: 1.4,end: 1.0),weight: 45.0),
        ]).animate(animationcontroller);
    degreeThreeTranslationAnimation =
        TweenSequence([
          TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0,end: 1.75),weight: 35.0),
          TweenSequenceItem<double>(tween: Tween<double>(begin: 1.75,end: 1.0),weight: 65.0),
        ]).animate(animationcontroller);
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(
      parent: animationcontroller,
      curve: Curves.easeIn,
    ));
    rotationforAdd = Tween(begin: 0.0, end: 230.0).animate(
      animationcontroller,
    );
    super.initState();
    animationcontroller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degreeOneTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))..scale(degreeOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.blue,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.local_post_office,
                          color: Colors.white,
                        ),
                        onClick: () {},
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degreeTwoTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))..scale(degreeTwoTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.black,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onClick: () {},
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degreeThreeTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))..scale(degreeThreeTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.orangeAccent,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onClick: () {},
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(getRadiansFromDegree(rotationforAdd.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Colors.red,
                      width: 70,
                      height: 70,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      onClick: () {
                        if (animationcontroller.isCompleted) {
                          animationcontroller.reverse();
                        } else {
                          animationcontroller.forward();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.width, this.height, this.icon, this.color, this.onClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      height: height,
      width: width,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
