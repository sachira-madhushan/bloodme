import "package:flutter/material.dart";

class DonerProfile extends StatefulWidget {
  const DonerProfile({super.key});

  @override
  State<DonerProfile> createState() => _DonerProfileState();
}

class _DonerProfileState extends State<DonerProfile> {
  
  
  
  
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
                    "Sachira Madhushan",
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
                          "Sachira Madhushan",
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
                          "O+",
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
                          "City",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Medirigiriya",
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
                          Icons.phone_android_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          "Contact",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "+94 783398454",
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
                  primary: Colors.orange,
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
