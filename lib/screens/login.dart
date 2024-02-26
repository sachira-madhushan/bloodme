import 'package:bloodme/screens/signin.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              // Image.asset(
              //   "assets/images/Login.png",
              //   width: 300,
              // ),
              Container(
                height: 200,
              ),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)))),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    obscureText: !_visibility,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
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
                            borderSide: BorderSide(color: Colors.purple)))),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(5),
                      minimumSize: Size(370, 50)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              ),
              Container(
                color: Colors.black12,
                child: Text(
                  "or",
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Signin();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                  child: Text("Create Account"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(5),
                      minimumSize: Size(370, 50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
