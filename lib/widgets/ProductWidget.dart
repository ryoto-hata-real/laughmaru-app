import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laughmaru/FireBase.dart';
import 'package:laughmaru/models/ProductListModel.dart';
import 'package:laughmaru/models/ProductModel.dart';
import 'package:provider/provider.dart';

import '../OrderForm.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _defaultValue = 1;
  // リストアイテム
  List<int> _list = <int>[1, 2, 3, 4, 5];
  int _num = 1;

  // onChangedのイベントハンドラ定義
  void _handleChange(int newValue) {
    setState(() {
      _num = newValue;
      _defaultValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var productBoxColor;

    return ChangeNotifierProvider(
      create: (_) => ProductListModel()..fetchProducts(),
      child: Consumer<ProductListModel>(builder: (context, model, child) {
        final products = model.products;
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (1 / 2),
          children: List.generate(
            products.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderForm(
                            products[index].productName,
                            products[index].productPrice)),
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
                                products[index].productName,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                products[index].productInfo,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '¥ ' + products[index].productPrice,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.indigo,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '個数：',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  DropdownButton<int>(
                                    value: _defaultValue,
                                    onChanged: (num) => _handleChange(num!),
                                    items: _list.map<DropdownMenuItem<int>>(
                                        (int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          value.toString(),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
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
      }),
    );
  }
}
