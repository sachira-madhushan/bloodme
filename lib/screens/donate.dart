import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/signin.dart';
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
  List<String> city = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.bloodtype,
          color: Colors.white,
        ),
        title: Text(
          "Blood Me",
          style: TextStyle(color: Colors.white),
        ),

        // leading: Icon(
        //   Icons.bloodtype,
        //   color: Colors.white,
        // ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Row(
            children: [
              DropdownButton(
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                items: city.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
              ),
              DropdownButton(
                value: selectedBlood,
                onChanged: (value) {
                  setState(() {
                    selectedBlood = value;
                  });
                },
                items: bloodGroups.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: "Donate"),
          //BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Blog"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
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
  }
}

class Post {
  final String title;
  final String imageUrl;

  Post({required this.title, required this.imageUrl});
}
