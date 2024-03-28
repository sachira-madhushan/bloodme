import 'package:bloodme/screens/login.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:flutter/material.dart';

class Signin2 extends StatefulWidget {
  const Signin2({super.key});

  @override
  State<Signin2> createState() => _SigninState2();
}

class _SigninState2 extends State<Signin2> {
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 9, 25, 1)!,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              left: 175,
              top: 100,
              child: Image.asset("assets/images/Logo.png")),
          Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(26, 34, 48, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 450,

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          TextField(
                              style: TextStyle(color: Colors.white70),
                              decoration: InputDecoration(
                                  prefixIconColor: Colors.white,
                                  hintText: "Phone",
                                  hintStyle: TextStyle(color: Colors.white54),
                                  prefixIcon: Icon(Icons.phone_android),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.purple)))),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: TextField(
                                style: TextStyle(color: Colors.white70),
                                obscureText: !_visibility,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.white,
                                    suffixIconColor: Colors.white,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _visibility = !_visibility;
                                          });
                                        },
                                        icon: Icon(_visibility
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: TextField(
                                style: TextStyle(color: Colors.white70),
                                obscureText: !_visibility,
                                decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.white,
                                    suffixIconColor: Colors.white,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _visibility = !_visibility;
                                          });
                                        },
                                        icon: Icon(_visibility
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  padding: EdgeInsets.all(5),
                                  minimumSize: Size(370, 50)),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return Signin();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(0.0, 1.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        var offsetAnimation =
                                            animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(color: Colors.orange[300]!),
                                ),
                                style: ElevatedButton.styleFrom(
                                    //primary: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    minimumSize: Size(380, 50)),
                              )),
                        ]),
                      ),
                    ],
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
