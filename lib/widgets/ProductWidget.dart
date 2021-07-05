import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laughmaru/FireBase.dart';
import 'package:laughmaru/models/ProductsModel.dart';

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

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> productList = getProductList();
    List<String> productsName = [
      'らふまるセット',
      '地元野菜セット',
      '府中農園セット',
    ];

    final productsInfo = [
      '水菜、スイスチャード、べカナ、ルッコラ、サラダホウレンソウ',
      '地元で取れた季節の野菜です。',
      'JGAP認証されている新鮮な野菜です。',
    ];

    var productBoxColor;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (1 / 2),
      children: List.generate(
        productsName.length,
        (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FireBase()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: productBoxColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("images/yasai_set.jpg"))),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 7.0, right: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsName[index],
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            productsInfo[index],
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            '¥ 1,980',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
