import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laughmaru/TopPage.dart';
import 'package:laughmaru/loginAndSignup/login_page.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:provider/provider.dart';

import 'loginAndSignup/LoginCheck.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Welcome to Flutter',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale("en"),
            const Locale("ja"),
          ],
          home: _LoginCheck(),
        ));
  }
}

class _LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ログイン状態に応じて、画面を切り替える
    final bool _loggedIn = context.watch<AuthModel>().loginFlag;
    return _loggedIn ? TopPage() : Home();
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('products');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget("らふまる野菜", false),
      body: SingleChildScrollView(
        child: LogInPage(),
      ),
    );
  }
}
