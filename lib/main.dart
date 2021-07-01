import 'package:flutter/material.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/RecipeWidget.dart';
import 'package:laughmaru/widgets/PurchaseWidget.dart';

void main() => runApp(MyApp());

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
        home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget("らふまる野菜"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PurchaseButton(),
            RecipeWidget(),

          ],
        ),
      ),
    );
  }
}
