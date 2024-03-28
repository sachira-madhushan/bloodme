import 'package:bloodme/screens/donerProfile.dart';
import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/Profile.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  int selectedIndex = 1;
  String? selectedValue = "Ampara";
  List<String> citys = [
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
  String? selectedBlood = "A+";
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  final List<String> name = ["Sachira", "Madhushan"];
  final List<String> blood = ["AB-", "O+"];
  final List<String> city = ["Polonnaruwa", "Medirigiriya"];

@override
  Widget build(BuildContext context) {
    return Scaffold(
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
          color: Color.fromRGBO(1, 9, 25, 1)!,
        ),
        child: Column(children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
                color: Color.fromRGBO(26, 34, 48, 1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                    child: Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        "Let's Find \nYour Doner!",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset("assets/images/Doc.png")),
                ]),
                Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
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
                                      ],
                ),
                Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.search)))
          
              ],
              
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
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
                      style: TextStyle(color: Colors.white),
                    ));
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
