import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;


  //signin
  Future<User?> signInWithaEmailAndPassword(String email,String password) async{
    try{
      UserCredential res=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=res.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


//sign up
Future<User?> registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential res=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=res.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign-out
  Future<void> signOut() async{
    try{
      return await _auth.signOut();

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}