import 'dart:convert';
import 'dart:ffi';
import 'package:bloodme/screens/posts.dart';
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
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
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

  bool userLoggedIn=false;
  Future<void> loggedInOrNot()async{
    final prefs=await data;
    setState(() {
      userLoggedIn= prefs.getBool("LoggedIn")!;
      if(userLoggedIn){
        loadData();
      }
    });
    
  }

  Future<void> sendDataToDonetePage()async{
    final prefs=await data;
    prefs.setString("selectedDistrict", selectedValue!);
    prefs.setString("selectedHospital", selectedHospital!);
    prefs.setString("selectedBlood", selectedBlood!);
  }

  Future<String> loadData()async{
    String? awesomeDialog="";
    final prefs=await data;


    var url=Uri.parse("http://192.168.56.1:8080/bloodme/getuser.php");


        String phoneNumber=prefs.getString("UserPhone")!;
    var req = {
            'Phone':phoneNumber!};

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

          if(ver=="1"){
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
    
      loggedInOrNot();
      
    
    
    
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
  List<String> hospitals = [
  'Hospital',
  'Ampara General Hospital',
  'Akkaraipattu Base Hospital',
  'Kalmunai Base Hospital',
  'Sammanthurai Base Hospital',
  'Pottuvil Base Hospital',
  'Lahugala Base Hospital',
  'Damana Base Hospital',
  'Teaching Hospital, Anuradhapura',
  'District General Hospital, Anuradhapura',
  'Medawachchiya Base Hospital',
  'Padaviya Base Hospital',
  'Horowpathana Base Hospital',
  'Mihintale Base Hospital',
  'Thambuttegama Base Hospital',
  'Badulla General Hospital',
  'Diyatalawa Base Hospital',
  'Mahiyanganaya Base Hospital',
  'Haliela Base Hospital',
  'Haputale Base Hospital',
  'Lunugala Base Hospital',
  'Welimada Base Hospital',
  'Batticaloa Teaching Hospital',
  'Batticaloa District General Hospital',
  'Batticaloa Base Hospital',
  'Chenkalady Base Hospital',
  'Eravur Base Hospital',
  'Kaluwanchikudy Base Hospital',
  'Kattankudy Base Hospital',
  'Kattankudy East Base Hospital',
  'Manmunai North Base Hospital',
  'Navaladi Base Hospital',
  'Oddamavadi Base Hospital',
  'Vakarai Base Hospital',
  'National Hospital',
  'Colombo South Teaching Hospital',
  'Colombo North Teaching Hospital',
  'Sri Jayewardenepura General Hospital',
  'Lady Ridgeway Hospital for Children',
  'Castle Street Hospital for Women',
  'Colombo General Hospital',
  'De Soysa Maternity Hospital',
  'Kalubowila Teaching Hospital',
  'Army Hospital, Colombo',
  'Sri Lanka Navy Hospital, Welisara',
  'Police Hospital, Narahenpita',
  'Karapitiya Teaching Hospital',
  'Galle General Hospital',
  'Balapitiya Base Hospital',
  'Elpitiya Base Hospital',
  'Ambalangoda Base Hospital',
  'Hikkaduwa Base Hospital',
  'Matara District General Hospital',
  'Tangalle Base Hospital',
  'Hambantota General Hospital',
  'Tissamaharama Base Hospital',
  'Kamburupitiya Base Hospital',
  'Kotapola Base Hospital',
  'Dikwella Base Hospital',
  'Walasmulla Base Hospital',
  'District General Hospital, Gampaha',
  'Ragama Teaching Hospital',
  'Negombo General Hospital',
  'Minuwangoda Base Hospital',
  'Wathupitiwala Base Hospital',
  'Divulapitiya Base Hospital',
  'Mirigama Base Hospital',
  'Ja-Ela Base Hospital',
  'Seeduwa Base Hospital',
  'Homagama Base Hospital',
  'Kadawatha Base Hospital',
  'Kaduwela Base Hospital',
  'Horana Base Hospital',
  'Bandaragama Base Hospital',
  'Biyagama Base Hospital',
  'Hambantota General Hospital',
  'Tissamaharama Base Hospital',
  'Ambalantota Base Hospital',
  'Angunakolapelessa Base Hospital',
  'Walasmulla Base Hospital',
  'Lunugamvehera Base Hospital',
  'Kataragama Base Hospital',
  'Beliatta Base Hospital',
  'Weerawila Base Hospital',
  'Jaffna Teaching Hospital',
  'Jaffna General Hospital',
  'Manthikai Base Hospital',
  'Chavakachcheri Base Hospital',
  'Point Pedro Base Hospital',
  'Kilinochchi General Hospital',
  'Poonakary Base Hospital',
  'Vavuniya General Hospital',
  'Vavuniya Base Hospital',
  'Mullaitivu District General Hospital',
  'Mullaitivu Base Hospital',
  'Kalutara General Hospital',
  'Nagoda General Hospital',
  'Panadura Base Hospital',
  'Horana Base Hospital',
  'Agalawatta Base Hospital',
  'Mathugama Base Hospital',
  'Beruwala Base Hospital',
  'Wadduwa Base Hospital',
  'Bandaragama Base Hospital',
  'Horawala Base Hospital',
  'Walallawita Base Hospital',
  'Madurawela Base Hospital',
  'Kandy General Hospital',
  'Peradeniya Teaching Hospital',
  'Central Province General Hospital, Peradeniya',
  'Mahiyangana Base Hospital',
  'Nawalapitiya Base Hospital',
  'Gampola Base Hospital',
  'Hatton Base Hospital',
  'Digana Base Hospital',
  'Teldeniya Base Hospital',
  'Theldeniya Base Hospital',
  'Panvila Base Hospital',
  'Udispattuwa Base Hospital',
  'District General Hospital, Kegalle',
  'Warakapola Base Hospital',
  'Mawanella Base Hospital',
  'Dehiowita Base Hospital',
  'Yatiyantota Base Hospital',
  'Rambukkana Base Hospital',
  'Deraniyagala Base Hospital',
  'Galigamuwa Base Hospital',
  'Bulathkohupitiya Base Hospital',
  'Hemmathagama Base Hospital',
  'Ruwanwella Base Hospital',
  'Kegalle Base Hospital',
  'Kilinochchi General Hospital',
  'Poonakary Base Hospital',
  'Mullaitivu District General Hospital',
  'Mullaitivu Base Hospital',
  'Mankulam Base Hospital',
  'Karachchi Base Hospital',
  'Vishvamadu Base Hospital',
  'Pachchilaippalli Base Hospital',
  'Kandawalai Base Hospital',
  'Murikandy Base Hospital',
  'Oddusuddan Base Hospital',
  'Thunukkai Base Hospital',
  'Iranamadu Base Hospital',
  'Kanagarayankulam Base Hospital',
  'Teaching Hospital, Kurunegala',
  'District General Hospital, Kurunegala',
  'Wariyapola Base Hospital',
  'Kuliyapitiya Base Hospital',
  'Nikaweratiya Base Hospital',
  'Galgamuwa Base Hospital',
  'Padeniya Base Hospital',
  'Polgahawela Base Hospital',
  'Giribawa Base Hospital',
  'Mahawa Base Hospital',
  'Ridigama Base Hospital',
  'Panduwasnuwara Base Hospital',
  'Gokarella Base Hospital',
  'Polpithigama Base Hospital',
  'Rasnayakapura Base Hospital',
  'Galagedara Base Hospital',
  'Yapahuwa Base Hospital',
  'Kobeigane Base Hospital',
  'Hettipola Base Hospital',
  'Alawwa Base Hospital',
  'Bingiriya Base Hospital',
  'Pannala Base Hospital',
  'Mannar District General Hospital',
  'Pooneryn Base Hospital',
  'Vidattaltivu Base Hospital',
  'Nanattan Base Hospital',
  'Vankalai Base Hospital',
  'Madhu Base Hospital',
  'Adampan Base Hospital',
  'Murunkan Base Hospital',
  'Thiruketheeswaram Base Hospital',
  'Alampil Base Hospital',
  'Mullikulam Base Hospital',
  'Matale General Hospital',
  'Dambulla Base Hospital',
  'Galewela Base Hospital',
  'Ukuwela Base Hospital',
  'Rattota Base Hospital',
  'Naula Base Hospital',
  'Wilgamuwa Base Hospital',
  'Laggala Pallegama Base Hospital',
  'Uthuwankanda Base Hospital',
  'Yatawatta Base Hospital',
  'Pallepola Base Hospital',
  'Matale Hospital',
  'Matara General Hospital',
  'Tangalle Base Hospital',
  'Hambantota General Hospital',
  'Kamburupitiya Base Hospital',
  'Kotapola Base Hospital',
  'Dikwella Base Hospital',
  'Walasmulla Base Hospital',
  'Deniyaya Base Hospital',
  'Akuressa Base Hospital',
  'Thihagoda Base Hospital',
  'Morawaka Base Hospital',
  'Dickwella District Hospital',
  'Monaragala General Hospital',
  'Bibile Base Hospital',
  'Wellawaya Base Hospital',
  'Badalkumbura Base Hospital',
  'Buttala Base Hospital',
  'Siyambalanduwa Base Hospital',
  'Madulla Base Hospital',
  'Kataragama Base Hospital',
  'Thanamalwila Base Hospital',
  'Suriyawewa Base Hospital',
  'Medagama Base Hospital',
  'Madulla North Base Hospital',
  'Monaragala Base Hospital',
  'Mullaitivu District General Hospital',
  'Mullaitivu Base Hospital',
  'Puthukudiyiruppu Base Hospital',
  'Maritimepattu Base Hospital',
  'Oddusuddan Base Hospital',
  'Mulliyawalai Base Hospital',
  'Thunukkai Base Hospital',
  'Mankulam Base Hospital',
  'Puthumattalan Base Hospital',
  'Vellamullivaikkal Base Hospital',
  'Puthukkudiyiruppu Base Hospital',
  'Vishwamadu Base Hospital',
  'Nuwara Eliya General Hospital',
  'Badulla General Hospital',
  'Diyathalawa Base Hospital',
  'Welimada Base Hospital',
  'Talawakelle Base Hospital',
  'Maskeliya Base Hospital',
  'Ragala Base Hospital',
  'Ginigathhena Base Hospital',
  'Kotagala Base Hospital',
  'Hatton Base Hospital',
  'Hatton Base Hospital',
  'Kotmale Base Hospital',
  'Agarapatana Base Hospital',
  'Kotmale Base Hospital',
  'Polonnaruwa General Hospital',
  'Hingurakgoda Base Hospital',
  'Medirigiriya Base Hospital',
  'Minneriya Base Hospital',
  'Manampitiya Base Hospital',
  'Lankapura Base Hospital',
  'Elahera Base Hospital',
  'Welikanda Base Hospital',
  'Dimbulagala Base Hospital',
  'Dehiattakandiya Base Hospital',
  'Kaduruwela Base Hospital',
  'Jayanthipura Base Hospital',
  'District General Hospital, Puttalam',
  'Chilaw General Hospital',
  'Puttalam Base Hospital',
  'Wennappuwa Base Hospital',
  'Nawagattegama Base Hospital',
  'Madampe Base Hospital',
  'Mundalama Base Hospital',
  'Naththandiya Base Hospital',
  'Anamaduwa Base Hospital',
  'Karuwalagaswewa Base Hospital',
  'Eluwankulama Base Hospital',
  'Maho Base Hospital',
  'Norochcholai Base Hospital',
  'Kalpitiya Base Hospital',
  'Wennappuwa Base Hospital',
  'Teaching Hospital, Ratnapura',
  'District General Hospital, Ratnapura',
  'Embilipitiya Base Hospital',
  'Kahawatta Base Hospital',
  'Balangoda Base Hospital',
  'Kuruwita Base Hospital',
  'Eheliyagoda Base Hospital',
  'Rakwana Base Hospital',
  'Elapatha Base Hospital',
  'Nivithigala Base Hospital',
  'Ayagama Base Hospital',
  'Kolonne Base Hospital',
  'Lunugala Base Hospital',
  'Godakawela Base Hospital',
  'Imbulpe Base Hospital',
  'Embilipitiya District General Hospital',
  'Rakwana District General Hospital',
  'Panadura General Hospital',
  'Trincomalee General Hospital',
  'Muttur Base Hospital',
  'Verugal Base Hospital',
  'Serunuwara Base Hospital',
  'Kinniya Base Hospital',
  'Kantale Base Hospital',
  'Morawewa Base Hospital',
  'Gomarankadawala Base Hospital',
  'Kuchchaveli Base Hospital',
  'Padaviya Base Hospital',
  'Thambalagamuwa Base Hospital',
  'Thiriyayi Base Hospital',
  'Kantalai Base Hospital',
  'Pulmoddai Base Hospital',
  'Kuchchaweli Base Hospital',
  'Nilaveli Base Hospital',
  'Sambalthivu Base Hospital',
  'Kuchchimunai Base Hospital',
  'Vavuniya General Hospital',
  'Vavuniya Base Hospital',
  'Nedunkeni Base Hospital',
  'Omanthai Base Hospital',
  'Pompemadu Base Hospital',
  'Puthukkudiyiruppu Base Hospital',
  'Puliyankulam Base Hospital',
  'Thandikulam Base Hospital',
  'Velikandalkadu Base Hospital',
  'Vavuniya South Base Hospital',
  'Vavuniya North Base Hospital'
];
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
      appBar: AppBar(toolbarHeight:40,
        automaticallyImplyLeading: false,
        title: Text(
          "BloodMe.lk",
          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
        ),

        // leading: Icon(
        //   Icons.bloodtype,
        //   color: Colors.white,
        // ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
           color: Color.fromRGBO(255, 255, 255, 1)!,
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
                  color: Color.fromRGBO(255, 255, 255, 1),
                  boxShadow:[BoxShadow(color: Colors.black38,offset:Offset.zero,spreadRadius:1,blurRadius:3)],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Positioned(child:CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/256/3135/3135768.png'), // Replace with your image asset
                    ),),Positioned(child:Icon(Icons.verified,color: verifiedOrNot? Colors.green:Colors.red,),bottom: 0,right: 0,)
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi "+name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.0),
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
                                border: Border.all(color: Colors.grey,width:2),
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(YoutubeThumbnail(youtubeId:video.split("=")[1]).hd()),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 0),
                                      blurRadius: 1,spreadRadius:1)
                                ],
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
                boxShadow: [
                  BoxShadow(color:Colors.black26,offset:Offset.zero,spreadRadius:1,blurRadius:2),
                ],
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
                    child: Align(alignment:Alignment.centerLeft,child: Text("Search a Donner",style: TextStyle(color: Colors.white,fontSize:20),)),
                  ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(20,0,20,0),
                        child: Column(children: [
                          SizedBox(
                            width: 300,
                            child: DropdownButton(
                              icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.transparent),
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
                                  fontSize:12,
                                  color: Colors.white,
                                ),
                              ));
                                                  }).toList(),
                                                ),
                          ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color: Colors.transparent),
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
                                  fontSize:12,
                                  color: Colors.white,
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width:300,
                      child: DropdownButton(
                        icon:Icon(Icons.arrow_drop_down_outlined,color:Colors.transparent),
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
                                  fontSize:12,
                                  color: Colors.white,
                                ),
                              ));
                        }).toList(),
                          ),
                    ),
                        Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(alignment:Alignment.centerLeft ,child: OutlinedButton(onPressed: (){
                sendDataToDonetePage();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Donate()));
              }, child:Text("Find",style:TextStyle(color: Colors.white,fontSize:15)),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red),),)),
            ),]),
            ),
            
            ],              
            ),
            ),
            SizedBox(
              height:50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width:350,
                child: PrettySlideUpButton(
                    bgColor: Color.fromARGB(255, 255, 175, 175),
                    onPressed:(){},
                    firstChild: const Text(
                      'BloodMe.lk',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    secondChild: const Text(
                      'BloodMe.lk',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width:350,
                child: PrettySlideUpButton(
                    bgColor: Color.fromARGB(255, 145, 242, 148),
                    onPressed:(){},
                    firstChild: const Text(
                      'About Developers',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    secondChild: const Text(
                      'Black Pixel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(26, 34, 48, 1)!,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: "Donate"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add_rounded), label: "Blogs"),
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
            builder: (context) => (Posts()),
          ));
    }
    if (selectedIndex == 3) {
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
