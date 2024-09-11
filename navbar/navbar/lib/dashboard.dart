import 'package:flutter/material.dart';
import 'homeS.dart';
import 'chatS.dart';
import "communityS.dart";
import "updatesS.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int sI = 0; // State index for BottomNavigationBar

  // List of background colors corresponding to each tab

  List<Widget>ScreenSelected=[
    const HomeS(),
    const UpdateS(),
    const CommunityS(),
    const ChatS()
  ];

    Color getSelectedItemColor() {
    switch (sI) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
        case 2:
        return Colors.green;
        case 3:
        return Colors.red;
      default:
        return Colors.orange; // Default color for other cases
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: sI,
        backgroundColor: Colors.orange,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 12,
        iconSize: 20,

        selectedItemColor:getSelectedItemColor(),
     
  
        onTap: (val) {
          setState(() {
            sI = val; // Update selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // Changed from upcomming to notifications
            label: "UPDATES",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "COMMUNITY",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "CHAT",
          ),
        ],
      ),
      body:ScreenSelected[sI]
    );
  }
}
