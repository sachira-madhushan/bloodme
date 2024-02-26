import 'package:bloodme/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:bloodme/screens/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _animated = true;
  @override
  void initState() {
    showanimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 185,
              right: 185,
              child: Image.asset(
                "assets/images/blood.png",
                width: 50,
              ),
            ),
            Positioned(
              top: 275,
              left: 130,
              right: 130,
              child: Image.asset(
                "assets/images/hand.png",
                width: 50,
              ),
            ),
            Positioned(
              top: 350,
              left: 145,
              right: 120,
              child: Text(
                "BLOOD ME",
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
            /*Positioned(
              top: 430,
              left: 80,
              right: 120,
              child: Text(
                "Donate Blood",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            Positioned(
              top: 430,
              left: 230,
              right: 0,
              child: Text(
                "Save Life",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            Positioned(
                top: 430,
                left: 230,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      showanimation();
                    },
                    icon: Icon(Icons.play_arrow))),*/
          ],
        ),
      ),
    );
  }

  Future showanimation() async {
    Future.delayed(Duration(seconds: 10));
    // setState(() {
    //   _animated = !_animated;
    // });
    //Future.delayed(Duration(milliseconds: 1000));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
    Navigator.pop(context);
  }
}
