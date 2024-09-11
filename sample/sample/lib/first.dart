import 'package:flutter/material.dart';

void main() {
  runApp(const First());
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        backgroundColor: Colors.deepPurpleAccent, // Changed background color to blue
        body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://tse3.mm.bing.net/th?id=OIP.Sx5Lip-QXzxS8C9-NSO-sQHaNK&pid=Api&P=0&h=180",
              ),
              radius: 100,
            ),
            const SizedBox(height: 30),
            const Text(
              "NK SHIVA CHANDRA",
              style: TextStyle(fontSize: 40, color: Colors.red),
            ),
            const SizedBox(height: 12),
            const Text(
              "SOFTWARE DEVELOPER",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.white,
                    child: const Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                     
                      
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.teal,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text("nkshivachandra@gmail.com")
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.white,
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.teal,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text("9901709661")
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.white,
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     
                      children:[
                        Icon(
                          Icons.school,
                          color: Colors.teal,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text("Master of Computer Applications")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    
    );
  }
}
