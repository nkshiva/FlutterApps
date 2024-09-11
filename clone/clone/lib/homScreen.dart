import "dart:convert";

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'ResturantScreen.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  var swiggyData;

  var lattitudeData, longitudeData;

  bool showProgress = false;

  Future fetchSwiggyData(lat, long) async {
    if (lat != null && long != null) {
      try {
        final dataOfSwiggy = await http.get(Uri.parse(
            "https://www.swiggy.com/dapi/restaurants/list/v5?lat=$lat&lng=$long&is-seo-homepage-enabled=true&page_type=DESKTOP_WEB_LISTING"));

        if (dataOfSwiggy.statusCode == 200) {
          return json.decode(dataOfSwiggy.body);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void getLatLong() async {
    setState(() {
      showProgress = true;
    });
    try {
      Position positionData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        lattitudeData = positionData.latitude;
        longitudeData = positionData.longitude;
      });
      print(
          "My Lat Laong is ${positionData.latitude},${positionData.longitude}");
      setState(() {
        showProgress = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLatLong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: FutureBuilder(
            future: fetchSwiggyData(lattitudeData, longitudeData),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.twistingDots(
                       size: 100,
                       leftDotColor: Colors.green,
                       rightDotColor: Colors.yellow),
                );
              } else if (snapshot.hasData) {
                int lengthOfArray = snapshot
                    .data['data']['cards'][0]['card']['card']['imageGridCards']
                        ['info']
                    ?.length;
        
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lengthOfArray,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height:100,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Card(
                                          color: Colors.yellow,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  child: Image.network(
                                                      "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/${snapshot.data['data']['cards'][0]['card']['card']['imageGridCards']['info'][index]['imageId']}")),
                                              Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Text(
                                                    "${snapshot.data['data']['cards'][0]['card']['card']['imageGridCards']['info'][index]['action']['text']}"),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              })),
                    ),
                        const Text("Restaurants with online food delivery in Manipal",style:TextStyle(fontSize:30,color:Colors.black)),
        
                     Expanded(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants']?.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantScreen(restId:snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants'][index]['info']['id'])));
                            },
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Image.network("https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/${snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants'][index]['info']['cloudinaryImageId']}",height: 150,width: 300),
                                      Text("${snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants'][index]['info']['name']}"),
                                      SizedBox(height: 20,),
                                      Text("${snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants'][index]['info']['avgRating']}"),
                                      SizedBox(
                                        height:10,
                                      ),
                                      Text("${snapshot.data['data']['cards'][4]['card']['card']['gridElements']['infoWithStyle']['restaurants'][index]['info']['costForTwo']}")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    )                
                  ],
                );
              } else {
                return const Text("Unknow Error");
              }
            },
          ),
        ),
      ),
    );
  }
}