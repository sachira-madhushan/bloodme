import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/login.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Signin2 extends StatefulWidget {
  const Signin2({super.key});

  @override
  State<Signin2> createState() => _SigninState2();
}

class _SigninState2 extends State<Signin2> {
  int selectedIndex = 1;
  String? selectedValue = "Select Your District";
  List<String> citys = [
    'Select Your District',
    'Akkaraipattu',
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Balangoda',
    'Bandarawela',
    'Batticaloa',
    'Chavakachcheri',
    'Chilaw',
    'Colombo',
    'Dambulla',
    'Dehiwela-Mount Lavinia',
    'Embilipitiya',
    'Eravur',
    'Galle',
    'Gampaha',
    'Gampola',
    'Hambantota',
    'Happutalle',
    'Homagama',
    'Jaffna',
    'Kalmunai',
    'Kalutara',
    'Kandy',
    'Kattankudy',
    'Kegalle',
    'Kinniya',
    'Kurunegala',
    'Kuliyapitiya',
    'Mahiyanganaya',
    'Mannar',
    'Matale',
    'Matara',
    'Mawathagama',
    'Mihintale',
    'Monaragala',
    'Mulleriyawa',
    'Negombo',
    'Nuwara Eliya',
    'Padukka',
    'Puttalam',
    'Polonnaruwa',
    'Point Pedro',
    'Ratnapura',
    'Sri Jayewardenepura Kotte',
    'Thambiluvil',
    'Trincomalee',
    'Valvettithurai',
    'Vavuniya',
    'Vijitapura'
  ];
  String? selectedBlood = "Blood Group";
  List<String> bloodGroups = [
    'Blood Group',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  
  String? selectedHospital="Hospital";
  List<String> hospitals=['Hospital','Medirigiriya','Polonnaruwa','Higurakgoda'];

  bool _visibility = false;

  final Future<SharedPreferences> data=SharedPreferences.getInstance();
  TextEditingController password=TextEditingController();
  TextEditingController repassword=TextEditingController();

  String nameData="";
  String nicData="";
  String phoneData="";
  String passwordData="";
  String bloodData="";
  String districtData="";
  AwesomeDialog successDialog(){
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'Register',
            desc: 'Registation Success!',
            btnOkOnPress: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
            },
            );
  }

  AwesomeDialog existDialog(){
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: 'Phone Number Already Exist!',
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
    prefs.setString("password", password.value.text.toString());
    prefs.setString("blood", selectedBlood!);
    prefs.setString("distric",selectedValue!);
    prefs.setString("hospital",selectedHospital!);
  }

  Future<String> signUp()async{
    String? awesomeDialog="";
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/register.php");
    var req = {'Name':prefs.getString("name")!,
            'NIC': prefs.getString("nic")!,
            'Phone':prefs.getString("phone")!,
            'District':prefs.getString("distric")!,
            'BloodGroup': prefs.getString("blood")!,
            'Hospital': prefs.getString("hospital")!,
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


        awesomeDialog= "success";
      }else if(resultDecode['result'].toString()=="exists"){
       awesomeDialog= "exists";
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
                  height: 500,

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
                        padding: EdgeInsets.fromLTRB(20,10,20,20),
                        child: Column(children: [
                          DropdownButton(
                         
                      dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      items: citys.map((option) {
                        return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ));
                      }).toList(),
                    ),
                    DropdownButton(
                      dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      value: selectedBlood,
                      onChanged: (value) {
                        setState(() {
                          selectedBlood = value;
                        });
                      },
                      items: bloodGroups.map((option) {
                        return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ));
                      }).toList(),
                    ),
                    DropdownButton(
                      dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      value: selectedHospital,
                      onChanged: (value) {
                        setState(() {
                          selectedHospital = value;
                        });
                      },
                      items: hospitals.map((option) {
                        return DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ));
                      }).toList(),
                    ),
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
                              onPressed: () {
                                saveDate();
                                
                                signUp().then((value){
                                  if(value!=null){
                                    if(value=="success"){
                                      successDialog()..show();
                                    }
                                    else if (value=="failed"){
                                      failedDialog()..show();
                                    }else if(value=="exists"){
                                      existDialog()..show();
                                    }
                                  }
                                });

                                
                               
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  //primary: Colors.orange,
                                  backgroundColor: Colors.orange,
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
