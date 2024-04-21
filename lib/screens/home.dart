import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:bloodme/screens/donate.dart';
import 'package:bloodme/screens/post.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/Profile.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/youtube.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'dart:async';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name="";
  bool verifiedOrNot=true;
  String bloodGroup="AB-";
  String verification ="verified";

  

  final List<String> youtubeVideoUrls=[];

  int selectedIndex = 0;
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

  final Future<SharedPreferences> data=SharedPreferences.getInstance();
  Future<String> loadData()async{
    String? awesomeDialog="";
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/getuser.php");


        String phoneNumber=prefs.getString("UserPhone")!;
    var req = {
            'Phone':prefs.getString("UserPhone")!};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);
    print(response.body);
    if(response.statusCode==200){
      setState(() {
        if(prefs.getBool("LoggedIn")!=null || !prefs.getBool("LoggedIn")!){
          name=resultDecode['name'];
          bloodGroup=resultDecode['blood'];
          var ver=resultDecode['verified'];

          if(ver=="T"){
            verification="Verified";
            verifiedOrNot=true;
          }else{
            verification="Not Verified";
            verifiedOrNot=false;
          }
        }else{
          name="John Doe";
          bloodGroup="NO";
          verification="Verified";
        }
        
      });
    }
    return awesomeDialog;
  }


  Future<void> getYoutubeVideos()async{
    String? awesomeDialog="";
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/youtubeVideos.php");
    var req = {
            'videos':"Youtube"};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        List<String> resultArray=resultDecode['videos'].split(" ");

        for (var element in resultArray) {
          youtubeVideoUrls.add(element);
        }
        print("Length :"+youtubeVideoUrls.length.toString() );
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    loadData();
    getYoutubeVideos();
    super.initState();
  }

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
  Future<void> _launchInBrowser(String url) async {
    print(url);

    if(await canLaunch(url)){

      await launcher.launchUrl(url,LaunchOptions(mode:PreferredLaunchMode.externalApplication ));
    }
   
  }
  String? selectedValue = "District";
  String? selectedHospital = "Hospital";
  List<String> hospitals=['Hospital','Medirigiriya','Polonnaruwa','Higurakgoda'];
  List<String> citys = [
    'District',
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
  String? selectedBlood = "Blood Group";
  List<String> bloodGroups = [
    'Blood Group',
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                          verification,
                          style: TextStyle(
                            color:verifiedOrNot? Colors.green:Colors.red,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Blood Group : '+bloodGroup,
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

                  height:150, // Adjust the height as needed
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                ),
                items: youtubeVideoUrls.map((video) {
                  print(video);
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                         _launchInBrowser(video);
                        },
                        
                        child: Stack(
                          children:[ Positioned(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                            
                              decoration: BoxDecoration(
                                
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.redAccent,width:5),
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(YoutubeThumbnail(youtubeId:video.split("=")[1]).hd()),
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: Colors.black45,
                                //       offset: Offset(0, 0),
                                //       blurRadius: 5)
                                // ],
                              ),
                            ),
                          ),
                          Positioned(child:Center(
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width:50,
                                
                                child:Image.asset("assets/images/play.png",),
                              ),
                            ),
                          ),)
                          ]
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
            Container(
              width:350,
              height:240,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:[
                  Colors.blue,
                  Colors.blue[900]!,
                
                ]),
              ),
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical:5),
                    child: Align(alignment:Alignment.centerLeft,child: Text("Search a Donner",style: TextStyle(color: Colors.white,fontSize:25),)),
                  ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(20,0,20,0),
                        child: Column(children: [
                          SizedBox(
                            width:300,
                            child: DropdownButton(
                              icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.white),
                              elevation: 5,
                                                     
                                                  dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.white),
                              elevation: 5,
                        
                        dropdownColor: Color.fromRGBO(26, 34, 48, 1),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        value: selectedHospital,
                        onChanged: (value) {
                          setState(() {
                            selectedHospital = value;
                          });
                        },
                        items: hospitals.map((option) {
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
                    ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.white),
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
                    ),
                        Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(alignment:Alignment.centerLeft ,child: OutlinedButton(onPressed: (){}, child:Text("Find",style:TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red)),)),
            ),
                        ]),
            )],              
            ),
            ),
            Text(
              'Health',
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:5),
                        child: ListTile(
                          title:Text(posts[index],style: TextStyle(color: Colors.white,fontSize:12),),
                          subtitle: Text("There are four type of blood"),
                          leading:Image.network("https://www.1mg.com/articles/wp-content/uploads/2016/11/rsz_shutterstock_478340209.jpg"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(alignment:Alignment.centerLeft ,child: OutlinedButton(onPressed: (){}, child:Text("Read More"),)),
            ),
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
