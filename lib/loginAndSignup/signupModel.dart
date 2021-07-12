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
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for tht email.');
      }
    } catch (e) {
      print(e);
    }
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
