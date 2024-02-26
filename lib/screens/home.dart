import 'package:bloodme/screens/donate.dart';
import 'package:bloodme/screens/signin.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1615461066159-fea0960485d5?q=80&w=1916&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1606206522398-de3bd05b1615?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1682309570054-e2fdcbb2c682?q=80&w=1824&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // Add more image URLs as needed
  ];
  int selectedIndex = 0;
  final List<String> posts = ["Post 01", "Post 02"];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Container(
                color: Colors.greenAccent, // Change the color as needed
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                          'https://cdn.icon-icons.com/icons2/3150/PNG/512/user_profile_female_icon_192701.png'), // Replace with your image asset
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Blood Group : AB-',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0, // Adjust the height as needed
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                ),
                items: imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0, 0),
                                blurRadius: 5)
                          ],
                        ),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Text(
              'Blogs',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
