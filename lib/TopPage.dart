import 'package:flutter/material.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/PurchaseWidget.dart';
import 'package:laughmaru/widgets/UserInfoWidget.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget("らふまる野菜", true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserInfoWidget(),
            PurchaseButton(),
          ],
        ),
      ),
    );
  }
}
