import 'package:firebase_auth/firebase_auth.dart';

import '../FirebaseModel/user.dart';

//The main firebase class where user can create account, sign in and log out
class AuthMethod{

  //Creating a unique user each time by making a user id class
  Users _userFromFirebaseUser(User user){
    return Users(userId: user.uid);
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Method for sign in. Data comes from textfield of sign in page
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      //Dont understand now but it is important
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    }catch(e){
      print(e);
    }
  }
//For sign up
  Future signUpWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    }catch(e){
      print(e);
    }
  }
//For resetting password
  Future resetPass(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e);
    }
  }

  //Logout
  Future signOut()async{
    try{
      return await _auth.signOut();

    }catch(e){
      print(e);
    }
  }

}