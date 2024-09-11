import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
class RestaurantScreen extends StatefulWidget {

  final restId;
  const RestaurantScreen({super.key, required this.restId});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
 
  @override
  void initState() {
  
    super.initState();
    print("RestaurantID is ${widget.restId}");
  }

  Future fetchRestaurentData()async{
    final dataOfSwiggy = await http.get(Uri.parse(
            "https://www.swiggy.com/dapi/menu/pl?page-type=REGULAR_MENU&complete-menu=true&lat=17.37240&lng=78.43780&restaurantId=${widget.restId}&catalog_qa=undefined&submitAction=ENTER"));

        if (dataOfSwiggy.statusCode == 200) {
          return json.decode(dataOfSwiggy.body);
        }
  }
  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Container(
        child: FutureBuilder(
          future: fetchRestaurentData(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  height: 600,
                  width:1200,
                  color: Colors.lightBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Text("${snapshot.data['data']['cards'][2]['card']['card']['info']['name']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                     Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 400,right:400),
                        child: Column(
                          children: [
                            Text("⭐ ${snapshot.data['data']['cards'][2]['card']['card']['info']['avgRatingString']} (${snapshot.data['data']['cards'][2]['card']['card']['info']['totalRatingsString']} ).${snapshot.data['data']['cards'][2]['card']['card']['info']['costForTwoMessage']}"),
                            SizedBox(
                              height: 20,
                            ),
                            

                          ],
                        ),

                      ),
                     ),
                     Expanded(
                       child: ListView.builder(
                                itemCount: snapshot.data['data']['cards'][4]['groupedCard']['cardGroupMap']['REGULAR']['cards'][3]['card']['card']['itemCards']?.length,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Card(
                                      elevation: 2,
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text("${snapshot.data['data']['cards'][4]['groupedCard']['cardGroupMap']['REGULAR']['cards'][3]['card']['card']['itemCards'][index]['card']['info']['name']}"),
                                      )),
                                  );
                                }
                                
                                ),
                     )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}