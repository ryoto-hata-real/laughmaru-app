import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:laughmaru/models/ProductModel.dart';

class ProductListModel extends ChangeNotifier {
  List<ProductModel> products = [];

  Future fetchProducts() async {
    final collection =
        await FirebaseFirestore.instance.collection('products').get();
    final products = collection.docs
        .map((doc) => ProductModel(
            doc.toString(), doc['name'], doc['info'], doc['price']))
        .toList();
    this.products = products;
    notifyListeners();
  }
}
