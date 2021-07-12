import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laughmaru/TopPage.dart';
import 'package:laughmaru/loginAndSignup/signupModel.dart';
import 'package:laughmaru/loginAndSignup/signup_page.dart';
import 'package:laughmaru/models/ProductListModel.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/ProductWidget.dart';
import 'package:provider/provider.dart';

import '../FireBase.dart';
import '../main.dart';
import 'loginModel.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    String errorMessage = '';

    return ChangeNotifierProvider(
      create: (_) => LogInModel(),
      child: Consumer<LogInModel>(builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            SizedBox(height: 60),
            TextField(
              decoration: InputDecoration(hintText: 'メールアドレスを入れてください'),
              controller: mailController,
              onChanged: (text) {
                model.mail = text;
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(hintText: 'パスワード'),
              controller: passwordController,
              onChanged: (text) {
                model.password = text;
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
                child: Text('ログインする'),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  fixedSize: Size(150.0, 50.0),
                  primary: Colors.black54,
                ),
                onPressed: () async {
                  try {
                    await model.logIn();
                    print('成功！！！');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TopPage()),
                    );
                  } catch (e) {
                    print('error');
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ログイン失敗'),
                            content: Text('メールアドレスかパスワードが違います。'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                  }
                }),
            SizedBox(height: 50.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  fixedSize: Size(250.0, 50.0),
                  primary: Color.fromARGB(255, 160, 77, 77),
                ),
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      )
                    },
                child: Text('会員登録はこちら'))
          ]),
        );
      }),
    );
  }
}
