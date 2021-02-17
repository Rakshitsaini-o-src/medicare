import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicare/modal/user_defined.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User_Defined _userFromFirebase(User user){
    return user != null ? User_Defined(userId: user.uid): null;
  }

  Future signInWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch(e){
      print(e.toString());
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
    }
  }
}