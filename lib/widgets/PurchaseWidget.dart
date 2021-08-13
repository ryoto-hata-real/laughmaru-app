import 'package:flutter/material.dart';

import '../PurchaseScreen.dart';

class PurchaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 500,
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 239, 239),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/yasai_set.jpg"))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "こだわりの野菜",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Text("JGAP認証、無農薬有機栽培で",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      )),
                  Text("育てられた超新鮮な野菜です。",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      )),
                  Text("当日の朝収穫したものをご自宅までお届けします。",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  fixedSize: Size(200.0, 80.0),
                  primary: Color.fromARGB(255, 160, 77, 77),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PurchaseScreen()),
                  );
                },
                child: const Text('注文する',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
