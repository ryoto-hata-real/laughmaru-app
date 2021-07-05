import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/ProductWidget.dart';

class FireBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot> buildProducts() async {
      await Future.delayed(Duration(seconds: 2));
      return FirebaseFirestore.instance.collection('products').get();
    }

    return FutureBuilder<QuerySnapshot>(
      future: buildProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<QueryDocumentSnapshot> datas = snapshot.data!.docs;
        List<String> products_list =
            List.generate(datas.length, (index) => datas[index].get('name'));
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: products_list.length, //並べたい要素の数を指定する
            itemBuilder: (context, int index) {
              // index はこの ListView における要素の番号
              return Text(
                products_list[index], // listItem の index 番目の要素を表示する
              );
            },
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text("Now ロード中"),
          );
        }
      },
    );
  }
}
