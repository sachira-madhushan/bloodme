import "dart:convert";
import "package:http/http.dart" as http;
import "package:bloodme/screens/login.dart";
import "package:bloodme/screens/notifications.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:bloodme/screens/donate.dart";
import "package:bloodme/screens/home.dart";
import "package:shared_preferences/shared_preferences.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future<SharedPreferences> data=SharedPreferences.getInstance();

  bool userLoggedIn=false;
  Future<void> loggedInOrNot()async{
    final prefs=await data;
    setState(() {
      userLoggedIn= prefs.getBool("LoggedIn")!;
      if(userLoggedIn){
      getDoner();
    }else{
      name="";
     phone="";
   district="";
   blood="";
   hospital="";
   nic="";
    }
    });
    
  }
  Future<void> logOut()async{
    final prefs=await data;
    setState(() {
      prefs.setBool("LoggedIn",false);
      loggedInOrNot();
    });
  }
  String name="";
  String phone="";
  String district="";
  String blood="";
  String hospital="";
  String nic="";

  @override
  void initState() {
    loggedInOrNot();
    
    
  }
  

  Future<void> getDoner()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/userProfile.php");
    var req = {
            'Phone':prefs.getString("UserPhone")};

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
          nic=element['NIC'].toString();
        }
      });
    }
  }
  int selectedIndex = 2;
  bool statusUpdate=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight:40,
       
        title: Text(
          "BloodMe.lk",
          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
        ),),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1)!,
      body: Stack(
        children: [
          
          Align(
            alignment: Alignment.center,
            child: Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/256/3135/3135768.png'), // Replace with your image asset
                            ),
                          ),
                        ),
                        //doner name
                        Text(
                          "Hello "+name+"!",
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                        Align(alignment: Alignment.topRight,child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active,color: Colors.red,)))
                      ],

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                    Card(child: Container(width:300,height:400,child: Column(
                      children: [
                        Card(child: ListTile(title:Text("Status :"+ (statusUpdate?"Online":"Offline")),trailing: Switch(
  activeColor: Color.fromARGB(255, 255, 255, 255),
  activeTrackColor: Color.fromARGB(255, 0, 255, 30),
  inactiveThumbColor: Colors.blueGrey.shade600,
  inactiveTrackColor: Colors.grey.shade400,
  splashRadius: 50.0,
  value: statusUpdate,
  onChanged: (value) => setState(() => statusUpdate = value),
),)),
Card(child: ListTile(title:Text("Full Name :"+name),)),
Card(child: ListTile(title:Text("Phone :"+phone),)),
Card(child: ListTile(title:Text("NIC :"+nic),)),
Card(child: ListTile(title:Text("District :"+district),)),
Card(child: ListTile(title:Text("Hospital :"+hospital),)),
                      ],
                    ),)),
                    userLoggedIn?buttonGroup():SizedBox(width:300,child: FilledButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    }, child: Text("Login")))
                  ],
                ),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
              
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(26, 34, 48, 1)!,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        items: [
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

  Widget buttonGroup(){
    return Column(
      children: [
        //SizedBox(width:300,child: FilledButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),onPressed: (){}, child: Text("Edit Profile"))),
                    SizedBox( width: 300,child: FilledButton(onPressed: (){

                      logOut();
                    }, child: Text("Logout"))),
      ],
    );
  }
}
