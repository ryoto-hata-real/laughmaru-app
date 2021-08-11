import 'package:flutter/material.dart';
import 'package:laughmaru/models/ProductListModel.dart';
import 'package:provider/provider.dart';

import '../OrderForm.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                        products[index].imageUrl))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 7.0, right: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].productName,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                products[index].productInfo,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '¥ ' + products[index].productPrice,
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
      }),
    );
  }
}
