import 'package:flutter/material.dart';
import 'package:laughmaru/loginAndSignup/login_page.dart';
import 'package:laughmaru/loginAndSignup/signup_page.dart';

class RecipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 500,
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/yasai.jpg"))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "おすすめレシピ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("ラフまる野菜をよりおいしく",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      )),
                  Text("召し上がっていただくために",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      )),
                  Text("シェフ直伝のレシピを公開しています。",
                      style: TextStyle(
                        fontSize: 17,
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
                    MaterialPageRoute(builder: (context) => LogInPage()),
                  );
                },
                child: const Text('レシピ一覧へ',
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
