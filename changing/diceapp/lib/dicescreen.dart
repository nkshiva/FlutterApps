import 'package:flutter/material.dart';
import 'dart:math';

class dicescreen extends StatefulWidget {
  const dicescreen({super.key});

  @override
  State<dicescreen> createState() => _dicescreenstate();
}

class _dicescreenstate extends State<dicescreen> {
  int dice1value = 2;
  int dice2value = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(55), // Make the corners fully rounded
                    child: Image.asset(
                      "images/dice$dice1value.png",
               // Ensure the image covers the entire area
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(55), // Make the corners fully rounded
                    child: Image.asset(
                      "images/dice$dice2value.png",
                     // Ensure the image covers the entire area
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          RawMaterialButton(
            fillColor: Colors.white,
            onPressed: () {
              setState(() {
                dice1value = Random().nextInt(6) + 1;
                dice2value = Random().nextInt(6) + 1;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Roll The Dice"),
            ),
          ),
          Text(
            "${dice1value + dice2value}",
            style: const TextStyle(fontSize: 54),
          ),
        ],
      ),
    );
  }
}
