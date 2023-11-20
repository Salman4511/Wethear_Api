
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'constants.dart' as K;
import 'dart:convert';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoaded=false;
  num? temp;
  num? pressure;
  num? humidity;
  num? clouds;
  String? cityName;
  TextEditingController search =  TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: 
          [Color(0xffFA8BFF),
          Color(0xff2BD2FF),
          Color(0xff2BFF88)
          ],begin: Alignment.bottomLeft,end: Alignment.topRight),
        ),
        child: Visibility(visible: isLoaded,
         child:Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height*0.07,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: TextFormField(
                  onFieldSubmitted: (String s) {
                    setState(() {
                      cityName=s;
                      getcitywethear(s);
                      isLoaded=false;
                      search.clear();
                      
                    });
                    
                  },
                  controller:search,
                  cursorColor: Colors.white,
                  style: TextStyle(color:Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: "Search City",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    border: InputBorder.none,
                  ),
                  
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.pin_drop,
                  color: Colors.red,size: 40,),
                  Text(cityName??"h",
                  style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.12,
              margin: EdgeInsets.symmetric(
                vertical: 10
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15),),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(1,2),
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: Colors.grey.shade900
                  )]
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/128/1684/1684426.png')
                    ,width: MediaQuery.of(context).size.width*0.15,
                    
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Temperature:${temp?.toStringAsFixed(2)}°C",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),)
                ],
              ),
            ),
             Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.grey.shade900)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/128/2569/2569196.png'),
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Pressure:${pressure?.toStringAsFixed(2)}hPa",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                 Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.grey.shade900)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/128/4148/4148388.png'),
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Humidity:${humidity?.toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                 Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.grey.shade900)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/128/414/414825.png'),
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cloud Cover:${clouds?.toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
          ],
         ),
         replacement: Center(child: CircularProgressIndicator(),)),
      ),
    ));
  }
  getCurrentLocation()async{
  var p = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low, 
    forceAndroidLocationManager: true
  );
  if (p!=null) {
    print('lat:${p.latitude}, long:${p.longitude}');
    getCurrentCityWethear(p);
  } else {
    print('data unavailable');
  }
  }
  getcitywethear(String cityName)async{
     var client = http.Client(); 
    var uri = '${K.domain}q=$cityName&appid=${K.apiKey}';
    var url= Uri.parse(uri);
    var response =await client.get(url);
    if (response.statusCode==200) {
      var data = response.body;
      var decodedData=json.decode(data);
      print(data);
      UpdateUi(decodedData);
      setState(() {
          isLoaded = true;
        });
    }
    else{
      print(response.statusCode);
    }
  }
  
  getCurrentCityWethear(Position position)async{
    var client = http.Client(); 
    var uri = '${K.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${K.apiKey}';
    var url= Uri.parse(uri);
    var response =await client.get(url);
    if (response.statusCode==200) {
      var data = response.body;
      var decodedData=json.decode(data);
      print(data);
      UpdateUi(decodedData);
      setState(() {
        isLoaded=true;
      });
    }else{
      print(response.statusCode);
    }
  }
  UpdateUi(var decodeData){
    setState(() {
      if (decodeData==null) {
      temp=0;
      humidity=0;
      pressure=0;
      clouds=0;
      cityName='Not Available';
      
    }
    else{
      temp=decodeData['main']['temp']-273;
      humidity=decodeData['main']['humidity'];
      pressure=decodeData['main']['pressure'];
      clouds=decodeData['clouds']['all'];
      cityName=decodeData['name'];
    }
    });
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    search.dispose();
    super.dispose();
  }
}