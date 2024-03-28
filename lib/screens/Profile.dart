import "package:bloodme/screens/login.dart";
import "package:bloodme/screens/notifications.dart";
import "package:flutter/material.dart";
import "package:bloodme/screens/donate.dart";
import "package:bloodme/screens/home.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 9, 25, 1)!,
      body: Stack(
        children: [
          Positioned(
              top: 90,
              left: 160,
              child: Column(
                children: [Image.asset("assets/images/Logo.png")],
              )),
          Positioned(
              top: 180,
              left: 22,
              child: Text(
                "Your support means the world to us",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              )),
          Positioned(
            top: 220,
            left: 125,
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.handshake_outlined),
                label: Text("Donate Us")),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                        "Hello John !",
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Card(
                        color: Colors.red[100],
                        child: ListTile(
                          title: Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                          trailing: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 164, 164),
                              ),
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                color: Color.fromARGB(255, 255, 17, 0),
                              )),
                          leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 164, 164),
                                  borderRadius: BorderRadius.circular(80)),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(255, 255, 17, 0),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications()));
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 239, 205, 255),
                        child: ListTile(
                          title: Text(
                            "Notifications",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 184, 54, 244),
                                fontSize: 25),
                          ),
                          trailing: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 225, 164, 255),
                              ),
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                color: Color.fromARGB(255, 132, 0, 255),
                              )),
                          leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 222, 164, 255),
                                  borderRadius: BorderRadius.circular(80)),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: Color.fromARGB(255, 140, 0, 255),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color.fromRGBO(26, 34, 48, 1),
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
}
