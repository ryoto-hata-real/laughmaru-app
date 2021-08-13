import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _user = '';
  String name = '';
  String postal = '';
  String address = '';
  String email = '';
  String tel = '';

  Future getUserInformation() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    final uid = user!.uid;
    final userInformation = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    userInformation.docs.forEach((doc) {
      print(doc['name']);
      print(doc['address']);
      this.name = doc['name'];
      this.address = doc['address'];
      this.email = doc['email'];
      this.tel = doc['tel'];
    });
    _user = uid;

    notifyListeners();
  }
}
