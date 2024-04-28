import 'package:bloodme/screens/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final List<String> posts = [
    "Blood Types: What They Are and Mean for Your Health",
    "Blood Types: What They Are and Mean for Your Health",
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
      body:Row(
        children: [
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:5),
                        child: ListTile(
                          title:Text(posts[index],style: TextStyle(color: Colors.black,fontSize:12),),
                          subtitle: Text("There are four type of blood",style: TextStyle(color: Colors.black26),),
                          leading:Image.network("https://www.1mg.com/articles/wp-content/uploads/2016/11/rsz_shutterstock_478340209.jpg"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

        ],
      )
    );
  }
}