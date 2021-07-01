import 'package:flutter/material.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/ProductWidget.dart';

class PurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget('商品一覧'),
      body: ProductWidget(),
    );
  }
}
