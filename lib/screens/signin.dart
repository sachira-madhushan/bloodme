import 'package:bloodme/screens/login.dart';
import 'package:bloodme/screens/signin2.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: TextField(
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    prefixIconColor: Colors.white,
                                    prefixIcon:
                                        Icon(Icons.supervisor_account_sharp),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)))),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: TextField(
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                    hintText: "NIC",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    prefixIconColor: Colors.white,
                                    prefixIcon: Icon(Icons.perm_identity),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)))),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: TextField(
                                style: TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                    hintText: "Blood Group",
                                    hintStyle: TextStyle(color: Colors.white54),
                                    prefixIconColor: Colors.white,
                                    prefixIcon: Icon(Icons.bloodtype),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Signin2();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
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
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  padding: EdgeInsets.all(5),
                                  minimumSize: Size(370, 50)),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Login();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: Text(
                            "Already Have An Account",
                            style: TextStyle(color: Colors.orange[300]!),
                          ),
                          style: ElevatedButton.styleFrom(
                              //primary: Colors.white,
                              padding: EdgeInsets.all(5),
                              minimumSize: Size(370, 50)),
                        ),
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
