import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:bloodme/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
  bool _visibility = false;

  final Future<SharedPreferences> data=SharedPreferences.getInstance();


  AwesomeDialog successDialog(){
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'Login',
            desc: 'Login Success!',
            btnOkOnPress: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
            },
            );
  }

  AwesomeDialog nouserDialog(){
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: 'Phone number or Password is incorrect!',
            btnOkOnPress: () {},
            );
  }

  AwesomeDialog failedDialog(){
    return AwesomeDialog(

            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: 'Register Failed!',
            btnOkOnPress: () {},
            );
  }
  Future<void> saveDate()async{
    final prefs=await data;
    prefs.setString("phone", phone.value.text.toString());
    prefs.setString("password", password.value.text.toString());
  }

  Future<String> signUp()async{
    String? awesomeDialog="";
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/login.php");
    var req = {
            'Phone':prefs.getString("phone")!,
            'Password': prefs.getString("password")!,};
    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);
    print(response.body);
    if(response.statusCode==200){
      if(resultDecode['result'].toString()=="success"){

        //is user logged in?
        prefs.setBool("LoggedIn", true);
        prefs.setString("UserPhone",prefs.getString("phone")!);
        print(prefs.getString("UserPhone"));
        awesomeDialog= "success";
      }else if(resultDecode['result'].toString()=="nouser"){
       awesomeDialog= "nouser";
      }else if(resultDecode['result'].toString()=="failed"){
        awesomeDialog="failed";
      }
    }
    return awesomeDialog;
  }
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
                  height: 400,

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          TextField(
                              controller:phone,
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
                              controller: password,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(color: Colors.orange),
                                )),
                          ),
                          ElevatedButton(
                            onPressed: () {
                                saveDate();
                                
                                signUp().then((value){
                                  if(value!=null){
                                    if(value=="success"){
                                      successDialog()..show();
                                    }
                                    else if (value=="failed"){
                                      failedDialog()..show();
                                    }else if(value=="nouser"){
                                      nouserDialog()..show();
                                    }
                                  }
                                });
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                //primary: Colors.orange,
                                backgroundColor:Colors.orange,
                                padding: EdgeInsets.all(5),
                                minimumSize: Size(370, 50)),
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
                                  return Signin();
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
                            "Create Account",
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
