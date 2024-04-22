import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloodme/screens/donerProfile.dart';
import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/Profile.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}


class _DonateState extends State<Donate> {
 final Future<SharedPreferences> data=SharedPreferences.getInstance();

  final List<String> name = [];
  final List<String> blood = [];
  final List<String> city =[];
  final List<String> userId =[];


  Future<void> getAllUsers()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/getAllUsers.php");
    var req = {
            'users':"Users"};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        //List<dynamic> resultArray=resultDecode;

        for (var element in resultDecode) {
          name.add(element['FullName']);
          blood.add(element['BloodGroup']);
          city.add(element['District']);
          userId.add(element['UserID']);
        }
      });
    }
  }

  Future<void> filterDoners()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/filterUsers.php");
    var req = {
            'Blood':selectedBlood,
            'Hospital':selectedHospital,
            'District':selectedValue};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        //List<dynamic> resultArray=resultDecode;
        if(resultDecode[0].toString()=="NA"){
          name.clear();
          blood.clear();
          city.clear();
          userId.clear();

          return;
        }else{
          for (var element in resultDecode) {
          name.clear();
          blood.clear();
          city.clear();
          userId.clear();

          name.add(element['FullName']);
          blood.add(element['BloodGroup']);
          city.add(element['District']);
          userId.add(element['UserID']);
          
          }
        }
        
      });
    }
  }

  Future<void> selectedDoner(String id) async{
    final prefs=await data;

    prefs.setString("selectedDonerID", id);
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }
  int selectedIndex = 1;
  String? selectedValue = "District";
  List<String> citys = [
    'District',
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
  

  String? selectedHospital = "Hospital";
  List<String> hospitals=['Hospital','Medirigiriya','Polonnaruwa','Higurakgoda'];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight:40,
       
        title: Text(
          "BloodMe.lk",
          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
        ),),
      // appBar: AppBar(
      //   leading: Icon(
      //     Icons.bloodtype,
      //     color: Colors.white,
      //   ),
      //   title: Text(
      //     "Blood Me",
      //     style: TextStyle(color: Colors.white),
      //   ),

      //   // leading: Icon(
      //   //   Icons.bloodtype,
      //   //   color: Colors.white,
      //   // ),
      //   backgroundColor: Colors.red,
      // ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1)!,
        ),
        child: Column(children: [
          Container(
              width:350,
              height:240,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color:Colors.black26,offset:Offset.zero,spreadRadius:1,blurRadius:2),
                ],
                borderRadius:BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:[
                  Colors.blue,
                  Colors.blue[900]!,
                
                ]),
              ),
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical:5),
                    child: Align(alignment:Alignment.centerLeft,child: Text("Search a Donner",style: TextStyle(color: Colors.white,fontSize:20),)),
                  ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(20,0,20,0),
                        child: Column(children: [
                          SizedBox(
                            width: 300,
                            child: DropdownButton(
                              icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.transparent),
                              elevation: 5,
                                                 
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
                                  fontSize:15,
                                  color: Colors.white,
                                ),
                              ));
                                                  }).toList(),
                                                ),
                          ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.transparent),
                              elevation: 5,
                        
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
                                  fontSize:15,
                                  color: Colors.white,
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color:Colors.transparent),
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
                                  fontSize:15,
                                  color: Colors.white,
                                ),
                              ));
                        }).toList(),
                          ),
                    ),
                        Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(alignment:Alignment.centerLeft ,child: OutlinedButton(onPressed: (){filterDoners();}, child:Text("Find",style:TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red)),)),
            ),
                        ]),
            )],              
            ),
            ),
            SizedBox(height: 10,),
          ListView.builder(
              shrinkWrap: true,
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  surfaceTintColor: Colors.white,
                  child: ListTile(
                      onTap: () {
                        selectedDoner(userId[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonerProfile()));
                      },
                      leading: const Icon(Icons.bloodtype),
                      trailing: Text(
                        blood[index],
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                     
                      subtitle: Text(city[index]),
                      title: Text(
                        name[index],
                        style: TextStyle(color: Colors.black),
                      )),
                );
              }),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(26, 34, 48, 1)!,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: "Donate"),
          //BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Blog"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ],
        currentIndex: selectedIndex,
        onTap: onTapNavigationBar,
      ),
    );
  }

  void onTapNavigationBar(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    }
    if (selectedIndex == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Donate(),
          ));
    }
    if (selectedIndex == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => (Profile()),
          ));
    }
  }
}

class Post {
  final String title;
  final String imageUrl;

  Post({required this.title, required this.imageUrl});
}
