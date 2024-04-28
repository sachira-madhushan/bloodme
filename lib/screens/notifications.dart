import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:bloodme/screens/donate.dart';
import 'package:bloodme/screens/post.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<String> title =[];
  final List<String> subtitle = [];
  final List<String> notificationIDs=[];
  final List<String> time = [];


  Future<void> getYoutubeVideos()async{
    String? awesomeDialog="";
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/notifications.php");
    var req = {
            'Notifications':"Notifications"};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        
        for (var element in resultDecode) {
          title.add(element['Title']);
          subtitle.add(element['Subtitle']);
          notificationIDs.add(element['n_id']);
          time.add(element['DateTime']);
        }
        
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getYoutubeVideos();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 9, 25, 1)!,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlogPost()));
                },
                leading: const Icon(Icons.notifications_active_outlined),
                trailing: Text(
                  time[index],
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                subtitle: Text(subtitle[index]),
                title: Text(
                  title[index],
                  style: TextStyle(color: Colors.white),
                ));
          }),
    );
  }
}
