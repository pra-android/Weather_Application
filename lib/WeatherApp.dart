import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapplication/Model.dart';
import 'package:weatherapplication/Model2.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  TextEditingController inputcontroller = TextEditingController();
  List<LatLong> geographicalcomponents = [];
  List<Model2> currentallweathers = [];
  List weatherdatas = [];
  Map map = {};
  Map wholedatamap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.teal,
                Colors.blue,
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: inputcontroller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                getweather();
                                getweatheralldata();
                              });
                            },
                            icon: Icon(Icons.search)),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
                        hintText: "Enter the City Name",
                        hintStyle: GoogleFonts.labrada(color: Colors.black),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                decoration: const BoxDecoration(),
                child: FutureBuilder(
                    future: getweather(),
                    builder: (contex, snapshot) {
                      if (!snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("Latitude",
                                    style: GoogleFonts.labrada(
                                        color: Colors.white, fontSize: 20)),
                                Text("0",
                                    style: GoogleFonts.labrada(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("City Name",
                                    style: GoogleFonts.labrada(
                                        color: Colors.white, fontSize: 20)),
                                Text("-",
                                    style: GoogleFonts.labrada(
                                        color: Colors.white, fontSize: 18)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Longitude",
                                    style: GoogleFonts.labrada(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontSize: 20)),
                                Text("0",
                                    style: GoogleFonts.labrada(
                                        color: Colors.white, fontSize: 18)),
                              ],
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                            itemCount: geographicalcomponents.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text("Latitude",
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 20)),
                                      Text(
                                          geographicalcomponents[index]
                                              .lat!
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 20)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("City Name",
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 20)),
                                      Text(
                                          geographicalcomponents[index]
                                              .name
                                              .toString(),
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 18)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Longitude",
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 20)),
                                      Text(
                                          geographicalcomponents[index]
                                              .lon!
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.labrada(
                                              color: Colors.white, fontSize: 18)),
                                    ],
                                  )
                                ],
                              );
                            });
                      }
                    }),
              ),
              Container(
                height: 135,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    map['temp'] == null
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("0 C",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 65)),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "${map['temp'].toString()} C",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 65),
                            ),
                          ),
                    (wholedatamap['weather']) == null
                        ? Text("Loading...",
                            style: GoogleFonts.labrada(
                                color: Colors.white, fontSize: 18))
                        : Text(
                            wholedatamap['weather'][0]['description'].toString(),
                            style: GoogleFonts.labrada(
                                color: Colors.white, fontSize: 18),
                          ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Container(
                height: 62,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 25,
                      child: Text("1"),
                    ),
                  ),
                  title: Text(
                    "Wind",
                    style: GoogleFonts.labrada(color: Colors.black, fontSize: 21),
                  ),
      
                  //
      
                  trailing: wholedatamap['main'] == null
                      ? Text(
                          "0.0",
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        )
                      : Text(
                          wholedatamap['main']['humidity'].toString(),
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 62,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 25,
                      child: Text("2"),
                    ),
                  ),
                  title: Text(
                    "Pressure",
                    style: GoogleFonts.labrada(color: Colors.black, fontSize: 21),
                  ),
      
                  //
      
                  trailing: wholedatamap['main'] == null
                      ? Text(
                          "0.0",
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        )
                      : Text(
                          wholedatamap['main']['pressure'].toString(),
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 62,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 25,
                      child: Text("3"),
                    ),
                  ),
                  title: Text(
                    "Sea Level",
                    style: GoogleFonts.labrada(color: Colors.black, fontSize: 21),
                  ),
      
                  //
      
                  trailing: wholedatamap['main'] == null
                      ? Text(
                          "0.0",
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        )
                      : Text(
                          wholedatamap['main']['sea_level'].toString(),
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 21),
                        ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 260,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Card(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/thermometer.png",
                                    height: 50,
                                  ),
                                                  wholedatamap['main']==null?Text("0.0",style: 
                                                  GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 18),
                                                  )              :      Text(
                                      wholedatamap['main']['temp_min'].toString(),
                                      style: GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 18))
                                ],
                              ),
                              Text("Min Temp",
                                  style: GoogleFonts.labrada(
                                      color: Colors.white, fontSize: 14))
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/thermometer.png",
                                    height: 50,
                                  ),
         wholedatamap['main']==null?Text("0.0",style: 
                                                  GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 18)):Text(
                                      wholedatamap['main']['temp_max'].toString(),
                                      style: GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 18)
                                          )
                                ],
                              ),
                              Text("Max Temp",
                                  style: GoogleFonts.labrada(
                                      color: Colors.white, fontSize: 14))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/sunrise.png",
                                    height: 60,
                                  ),
         wholedatamap['sys']==null?Text("0.0",style: 
                                                  GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 18)):                          Text(
                                      wholedatamap['sys']['sunrise'].toString(),
                                      style: GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 16))
                                ],
                              ),
                              Text("Sun Rise",
                                  style: GoogleFonts.labrada(
                                      color: Colors.white, fontSize: 15))
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/sunset.png",
                                    height: 60,
                                  ),
                 wholedatamap['sys']==null?Text("0.0",
                 style:GoogleFonts.labrada(
                  color: Colors.white,fontSize: 16
                 ),
                 ):                  Text(
                                      wholedatamap['sys']['sunset'].toString(),
                                      style: GoogleFonts.labrada(
                                          color: Colors.white, fontSize: 16))
                                ],
                              ),
                              Text("Sun Set",
                                  style: GoogleFonts.labrada(
                                      color: Colors.white, fontSize: 15))
                            ],
                          ),
                        ],
                      ),
      
      
      
      
      
                      
                       
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<LatLong>> getweather() async {
    var response = await http.get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/direct?q=${inputcontroller.text}&limit=1&appid=78143dce0158cb1c9e856de355eb416e"));
    if (response.statusCode == 200) {
      var output = json.decode(response.body.toString());
      for (Map<String, dynamic> i in output) {
        geographicalcomponents = [];
        geographicalcomponents.add(LatLong.users(i));
        print(geographicalcomponents);
      }

      return geographicalcomponents;
    } else {
      return geographicalcomponents;
    }
  }

  Future<void> getweatheralldata() async {
    final latlongapi =
        "http://api.openweathermap.org/geo/1.0/direct?q=${inputcontroller.text}&limit=1&appid=78143dce0158cb1c9e856de355eb416e";
    var data = await http.get(Uri.parse(latlongapi));
    var decodeddata = json.decode(data.body.toString());
    print(decodeddata);
    for (Map<String, dynamic> i in decodeddata) {
      geographicalcomponents = [];
      geographicalcomponents.add(LatLong.users(i));
      print(geographicalcomponents);
    }

    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${geographicalcomponents[0].lat.toString()}&lon=${geographicalcomponents[0].lon}&appid=78143dce0158cb1c9e856de355eb416e&units=metric";
    var curentweatherdata = await http.get(Uri.parse(url));

    if (curentweatherdata.statusCode == 200) {
      var actualdata = json.decode(curentweatherdata.body.toString());
      var main = actualdata['main'];

      print(actualdata);
      print(actualdata.runtimeType);

      setState(() {
        map = main;
        wholedatamap = actualdata;
        print(wholedatamap);
        print(wholedatamap.runtimeType);
      });
    }

    /*for(Map<String,dynamic> j  in actualdata)
    {
      print(j);
      currentallweathers=[];
      currentallweathers.add(Model2.tojson(j));
      print(currentallweathers);
    }*/
  }
}
