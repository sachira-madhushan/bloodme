import "dart:convert";
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";

class DonerProfile extends StatefulWidget {
  const DonerProfile({super.key});

  @override
  State<DonerProfile> createState() => _DonerProfileState();
}

class _DonerProfileState extends State<DonerProfile> {
  
  
  
  final Future<SharedPreferences> data=SharedPreferences.getInstance();
  
  String name="";
  String phone="";
  String district="";
  String blood="";
  String hospital="";



  Future<void> getDoner()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/getUserByID.php");
    var req = {
            'ID':prefs.getString("selectedDonerID")};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        //List<dynamic> resultArray=resultDecode;

        for (var element in resultDecode) {
          name=element['FullName'].toString();
          blood=element['BloodGroup'].toString();
          district=element['District'].toString();
          hospital=element['Hospital'].toString();
          phone=element['Phone'].toString();
        }
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


  @override
  void initState() {
    getDoner();
    super.initState();
  }
  
  //meke calls
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 9, 25, 1)!,
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  width: 150,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(26, 34, 48, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100))),
                )),
                Positioned(
                    top: 100,
                    left: 35,
                    child: Text(
                      "Doner",
                      style: TextStyle(color: Colors.orange, fontSize: 25),
                    )),
                Positioned(
                    top: 150,
                    left: 30,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/256/3135/3135768.png"),
                    )),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    "Verified",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 175,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Colors.blue,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          name,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(26, 34, 48, 1),
                ),
              ),
              Container(
                width: 175,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.bloodtype_outlined,
                          color: Colors.red,
                        ),
                        Text(
                          "Blood Group",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          blood,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(26, 34, 48, 1),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 175,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.orange,
                        ),
                        Text(
                          "District",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          district,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(26, 34, 48, 1),
                ),
              ),
              Container(
                width: 175,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.medical_information,
                          color: Colors.green,
                        ),
                        Text(
                          "Hospital",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          hospital,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(26, 34, 48, 1),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                _makePhoneCall(phone);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "Contact",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  //primary: Colors.orange,
                  backgroundColor: Colors.orange,
                  //padding: EdgeInsets.all(5),
                  minimumSize: Size(370, 50)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Back",
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
    );
  }
}
