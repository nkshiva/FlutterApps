import 'package:flutter/material.dart';

enum SelectedButton {
  Beginner, Intermediate, Advanced
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailAddress = "";
  String name = "";
  String password = "";
  bool showPassword = true;
  SelectedButton _selectedValue = SelectedButton.Beginner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Changed color to a lighter yellow
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "REGISTRATION FORM",
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: TextField(
                onChanged: (na) {
                  name = na;
                },
                decoration: InputDecoration(
                  hintText: "Please Enter your Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300], // Slightly darker grey
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  emailAddress = value;
                },
                decoration: InputDecoration(
                  hintText: "Please Enter your Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: showPassword,
                decoration: InputDecoration(
                  hintText: "Please Enter your Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("How proficient are you in Flutter?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      value: SelectedButton.Beginner,
                      groupValue: _selectedValue,
                      onChanged: (SelectedButton? val) {
                        setState(() {
                          _selectedValue = val!;
                        });
                      },
                    ),
                    Text("Beginner"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: SelectedButton.Intermediate,
                      groupValue: _selectedValue,
                      onChanged: (SelectedButton? val) {
                        setState(() {
                          _selectedValue = val!;
                        });
                      },
                    ),
                    Text("Intermediate"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: SelectedButton.Advanced,
                      groupValue: _selectedValue,
                      onChanged: (SelectedButton? val) {
                        setState(() {
                          _selectedValue = val!;
                        });
                      },
                    ),
                    Text("Advanced"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("So, you are a: ${_selectedValue.toString().split('.').last}"),
          ],
        ),
      ),
    );
  }
}
