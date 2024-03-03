import 'package:bloodme/screens/donate.dart';
import 'package:bloodme/screens/post.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/Profile.dart';
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
  final List<String> posts = [
    "Blood Types: What They Are and Mean for Your Health",
    "Blood Types: What They Are and Mean for Your Health",
    "Blood Types: What They Are and Mean for Your Health",
    "Blood Types: What They Are and Mean for Your Health"
  ];
  final List<String> postsSubtitle = [
    "Subtitle 01",
    "Subtitle 02",
    "Subtitle 03",
    "Subtitle 04"
  ];
  final List<String> postImages = ["", ""];
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
        height: 1000,
        decoration: BoxDecoration(
          color: Color.fromRGBO(1, 9, 25, 1)!,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                // Change the color as needed
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(26, 34, 48, 1),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/256/3135/3135768.png'), // Replace with your image asset
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
                            color: Colors.orange,
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
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              url,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0, 0),
                                blurRadius: 5)
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              width: 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Text(
              'Blogs',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 16.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: GestureDetector(
                      //post tap handle here
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlogPost()));
                        print('Tapped on item ${index + 1}');
                      },
                      child: Card(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    posts[index],
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white70),
                                  ),
                                ),
                              ),
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0),
                                      Color.fromRGBO(0, 0, 0, 0.3),
                                      Color.fromRGBO(0, 0, 0, 0.9),
                                    ]),
                              )),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  //post image handle here
                                  image: NetworkImage(
                                      "https://www.1mg.com/articles/wp-content/uploads/2016/11/rsz_shutterstock_478340209.jpg"))),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
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
}

class Post {
  final String title;
  final String imageUrl;

  Post({required this.title, required this.imageUrl});
}
