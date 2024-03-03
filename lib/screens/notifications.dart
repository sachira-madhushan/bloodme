import 'package:bloodme/screens/donate.dart';
import 'package:bloodme/screens/post.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<String> notification = ["Blood Donation Camp", "New Post Added"];
  final List<String> time = ["6:15", "15:20"];
  final List<String> subtitle = ["Polonnaruwa", "Health"];
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
          itemCount: notification.length,
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
                  notification[index],
                  style: TextStyle(color: Colors.white),
                ));
          }),
    );
  }
}
