import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var dataofDB;
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String emailAddress, password;
  final authInstance = FirebaseAuth.instance;
  final dbInstance = FirebaseFirestore.instance;

  void getUserData()async{
    final data = await dbInstance.collection("Users").get();
    setState(() {
       dataofDB = data.docs[0].data();
    });
   
    print("daa is $dataofDB");
    // return dataOfDB;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              onChanged: (val){
                emailAddress = val;
              },
              decoration: const InputDecoration(
                hintText: "Please Enter Email",
                 filled: true,
                fillColor: Colors.grey
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              onChanged: (val){
                password = val;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Please create a password",
                filled: true,
                fillColor: Colors.grey
              ),
            ),
          ),
          RawMaterialButton(
            fillColor: Colors.grey,
          onPressed: ()async{
            if(emailAddress!= "" && password !=""){
              try{
            await authInstance.createUserWithEmailAndPassword(email: emailAddress, password: password);
              }catch(error){
                print("The error is ${error.toString()}");
              }
            }
            if(authInstance.currentUser !=null){
              await dbInstance.collection("Users").doc(authInstance.currentUser?.uid).set(
                {
                  "email":emailAddress.toString(),
                  "password":password.toString()
                }
              );

            }
           
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Register"),
          ),
          
          ),
          RawMaterialButton(
            fillColor: Colors.grey,
          onPressed: ()async{
            if(emailAddress!= "" && password !=""){
              try{
            await authInstance.signInWithEmailAndPassword(email: emailAddress, password: password);
              }catch(error){
                print("The error is ${error.toString()}");
              }
            }
           
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Sign In"),
          ),
          
          ),
          Text("$dataofDB")
        ],
      ),
    );
  }
}