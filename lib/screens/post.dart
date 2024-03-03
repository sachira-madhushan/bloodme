import 'package:flutter/material.dart';

class BlogPost extends StatefulWidget {
  const BlogPost({super.key});

  @override
  State<BlogPost> createState() => _PostState();
}

class _PostState extends State<BlogPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(
            child: Text(
              "BloodMe Health",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(1, 9, 25, 1)!,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "https://www.1mg.com/articles/wp-content/uploads/2016/11/rsz_shutterstock_478340209.jpg"),
                )),
              ),
              Text(
                textAlign: TextAlign.center,
                "Blood Types: What They Are and Mean for Your Health",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 26,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
              Text(
                "2024-05-06",
                style: TextStyle(color: Colors.orange),
              ),
              //post
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "There are 4 main blood groups (types of blood) – A, B, AB and O. Your blood group is determined by the genes you inherit from your parents.Each group can be either RhD positive or RhD negative, which means in total there are 8 blood groups.Blood is made up of red blood cells, white blood cells and platelets in a liquid called plasma. Your blood group is identified by antibodies and antigens in the blood.Antibodies are proteins found in plasma. They're part of your body's natural defences. They recognise foreign substances, such as germs, and alert your immune system, which destroys them.Antigens are protein molecules found on the surface of red blood cells.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(38, 42, 50, 1)!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
