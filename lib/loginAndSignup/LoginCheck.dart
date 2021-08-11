import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool loginFlag = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel() {
    final User? _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      loginFlag = true;
      notifyListeners();
    }
  }
}
