//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmate/homescreen.dart';
import 'package:taskmate/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmate/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth=AuthService();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passController=TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Sign in"),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Welcome back",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
              ),
              SizedBox(height: 10,),
              Text("Sign In",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )
              ),
              SizedBox(height: 40,),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  

                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white60,
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _passController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  

                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white60,
                  )
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width/1.6,
                child: ElevatedButton(onPressed: ()async{
                  User? user =await _auth.signInWithaEmailAndPassword(
                    _emailController.text,
                    _passController.text,   
                  );
                  if(user!=null){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(),));
                  }
                }, child: Text('Sign In',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "OR",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>
                  SignupScreen(),
                )
                );
              }, child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              )
            ],
          ),
        
        )
      ),
    );
  }
}