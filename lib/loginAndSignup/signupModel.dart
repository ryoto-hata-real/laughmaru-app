import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughmaru/models/ProductModel.dart';

class SignUpModel extends ChangeNotifier {
  String name = '';
  String address = '';
  String mail = '';
  String password = '';
  String tel = '';

  Future signUp() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);
    FirebaseFirestore.instance.collection('users').add(
      {
        'name': name,
        'address': address,
        'email': mail,
        'tel': tel,
        'createdAt': Timestamp.now(),
      },
    );
  }
}
