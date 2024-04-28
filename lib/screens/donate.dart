import 'dart:convert';
import 'package:bloodme/screens/posts.dart';
import 'package:http/http.dart' as http;
import 'package:bloodme/screens/donerProfile.dart';
import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/Profile.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}


class _DonateState extends State<Donate> {
 final Future<SharedPreferences> data=SharedPreferences.getInstance();

  final List<String> name = [];
  final List<String> blood = [];
  final List<String> city =[];
  final List<String> userId =[];
  final List<String> nic =[];
  Future<void> getDataFromHome()async{
    final prefs=await data;
    selectedValue=prefs.getString("selectedDistrict");
    selectedHospital=prefs.getString("selectedHospital");
    selectedBlood=prefs.getString("selectedBlood");
  }
  Future<void> getAllUsers()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/getAllUsers.php");
    var req = {
            'users':"Users"};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        //List<dynamic> resultArray=resultDecode;

        for (var element in resultDecode) {
          name.add(element['u_name']);
          blood.add(element['u_blood_group']);
          city.add(element['u_town']);
          userId.add(element['u_id']);
          nic.add(element['u_nic']);
        }
      });
    }
  }

  Future<void> filterDoners()async{
    final prefs=await data;
    var url=Uri.parse("http://192.168.56.1:8080/bloodme/filterUsers.php");
    var req = {
            'Blood':selectedBlood,
            'Hospital':selectedHospital,
            'District':selectedValue};

    var body = json.encode(req);
    var response = await http.post(url, body: body);
    var resultDecode=json.decode(response.body);

    print(response.body);
    if(response.statusCode==200){
      setState(() {
        //List<dynamic> resultArray=resultDecode;
        if(resultDecode[0].toString()=="NA"){
          name.clear();
          blood.clear();
          city.clear();
          userId.clear();

          return;
        }else{
          
          name.clear();
          blood.clear();
          city.clear();
          userId.clear();
          for (var element in resultDecode) {
          
            
          
          name.add(element['u_name']);
          blood.add(element['u_blood_group']);
          city.add(element['u_town']);
          userId.add(element['u_id']);
          nic.add(element['u_nic']);
          }
        }
        
      });
    }
  }

  Future<void> selectedDoner(String id) async{
    final prefs=await data;

    prefs.setString("selectedDonerID", id);
  }

  @override
  void initState() {
    getDataFromHome();
    filterDoners();
    
    super.initState();
  }
  int selectedIndex = 1;
  String? selectedValue = "District";
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

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight:40,
        automaticallyImplyLeading:false,
        title: Text(
          "BloodMe.lk",
          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),
        ),),
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
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1)!,
        ),
        child: Column(children: [
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
              child: Container(alignment:Alignment.centerLeft ,child: OutlinedButton( onPressed: (){filterDoners();}, child:Text("Find",style:TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red)),)),
            ),
                        ]),
            )],              
            ),
            ),
            SizedBox(height: 10,),
          ListView.builder(
              shrinkWrap: true,
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color:Color.fromARGB(255, 255, 255, 255) ,
                  child: ListTile(
                      onTap: () {
                        selectedDoner(userId[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonerProfile()));
                      },
                      leading: const Icon(Icons.bloodtype,color: Colors.white,),
                      trailing: Text(
                        blood[index],
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                     
                      subtitle: Text("Age :"+getAge(nic[index])+" Town :"+city[index]),
                      title: Text(
                        name[index],
                        style: TextStyle(color: Colors.black),
                      )),
                );
              }),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(26, 34, 48, 1)!,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: "Donate"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add_rounded), label: "Blogs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ],
        currentIndex: selectedIndex,
        onTap: onTapNavigationBar,
      ),
    );
  }
  String getAge(String nicNumber){

    int birthYear=0;
    if (nicNumber.length == 10) {

    int yearCode = int.parse(nicNumber.substring(0, 2));
    if (yearCode >= 0 && yearCode <= 13) {
      birthYear = 2000 + yearCode;
    } else {
      birthYear = 1900 + yearCode;
    }
  } else if (nicNumber.length == 12) {

    birthYear = int.parse(nicNumber.substring(0, 4));
  }

   DateTime now = DateTime.now();
  int currentYear = now.year;
  int age = currentYear - birthYear;
  return age.toString();
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
  }
}

class Post {
  final String title;
  final String imageUrl;

  Post({required this.title, required this.imageUrl});
}
