import 'package:flutter/material.dart';
import 'package:weatherapplication/WeatherApp.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(height:15),
          Image.asset("assets/sunny3.png"),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("Breeze Tool",style: TextStyle(color: Colors.white,fontSize: 29,
          fontWeight: FontWeight.bold),),
         

            ],
          ),
          Text("A Weather App",style: TextStyle(color: Colors.white.withOpacity(0.5)),),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text("It is the weather app developed on 10/07/2023.Can be Install on both android and IOS.All rights reserved.",
            style: GoogleFonts.lato(fontSize: 13,color:Colors.white),),),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("AutoLayout",style: GoogleFonts.labrada(fontSize: 18,color:Colors.white),),
              Text("Organized Layers",style: GoogleFonts.labrada(fontSize: 18,color:Colors.white),),

            ],
          ),
             
        SizedBox(height:65),
           Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    
                    width: 2,
                    color: Colors.black
                  ),
                   borderRadius: BorderRadius.circular(10)

                ),
               
                height: 59,
                width: 130,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Later",style: GoogleFonts.labrada(fontSize: 18,color:Colors.black)
                    ),
                    
                    
                  ],
                ),
              ),
              InkWell(
                onTap: ()  {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WeatherApp()));
                    
                  });
                  
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                     borderRadius: BorderRadius.circular(5)
              
                  ),
                 
                  height: 59,
                  width: 130,
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Go To",style: GoogleFonts.labrada(fontSize: 19,color:Colors.black)
                      ),
                      Icon(Icons.arrow_right_alt,size: 28,),
                      
                    ],
                  ),
                ),
              ),


              //



              
            ],
          ),
          SizedBox(height:30),
          Text("Developed By:Prabin BhattaraiⒸ", style: GoogleFonts.labrada(fontSize: 10,color:Colors.white),)

        ],
      ),


    );
  }
}


