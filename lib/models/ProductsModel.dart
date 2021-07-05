import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel extends ChangeNotifier {
  String productName = 'name';
  String productInfo = 'info';
  String productPrice = '1,980';
  ProductModel(this.productName, this.productInfo, this.productPrice);
  List<ProductModel> getProductList() {
    List<ProductModel> productList = [];
    Future<QuerySnapshot> buildProducts() {
      return FirebaseFirestore.instance.collection('products').get();
    }

    FutureBuilder<QuerySnapshot>(
      future: buildProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<QueryDocumentSnapshot> datas = snapshot.data!.docs;
        List.generate(
            datas.length,
            (index) => productList.add(ProductModel(datas[index].get('name'),
                datas[index].get('info'), datas[index].get('price'))));
        return Text('完了');
      },
    );
    return productList;
  }
}
