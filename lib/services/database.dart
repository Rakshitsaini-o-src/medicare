import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getGeneralUserData(String email) async{
    return await FirebaseFirestore.instance
        .collection('Profile')
        .doc(email)
        .collection('Data')
        .doc('general')
        .get();
  }
  uploadUserEmailInfo(userMap,String email){
    FirebaseFirestore.instance.collection('Profile').doc(email).set(userMap);
  }
  uploadUserData(userMap,String email){
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(email)
        .collection('Data')
        .doc('general')
        .set(userMap);
  }
  getMedicalUserData(String email) async{
    return await FirebaseFirestore.instance
        .collection('Profile')
        .doc(email)
        .collection('Data')
        .doc('medical')
        .get();
  }
  uploadMedicalData(userMap,String email){
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(email)
        .collection('Data')
        .doc('medical')
        .set(userMap);
  }

}