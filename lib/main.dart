import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laughmaru/FireBase.dart';
import 'package:laughmaru/loginAndSignup/login_page.dart';
import 'package:laughmaru/loginAndSignup/signup_page.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/RecipeWidget.dart';
import 'package:laughmaru/widgets/PurchaseWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class ProductInfo extends StatelessWidget{
//   @override
//   _ProductInfoState createState() => _ProductInfoState();
// }
//
// class _ProductInfoState extends State<ProductInfo>{
//   @override
//   Widget build(BuildContext context){
//     return Padding
//   }
// }
//

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        home: Home());
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
      appBar: AppBarWidget("らふまる野菜"),
      body: SingleChildScrollView(
        child: LogInPage(),
      ),
    );
  }
}
