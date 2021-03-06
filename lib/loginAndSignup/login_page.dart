import 'package:flutter/material.dart';
import 'package:laughmaru/TopPage.dart';
import 'package:laughmaru/loginAndSignup/signup_page.dart';
import 'package:laughmaru/models/userModel.dart';
import 'package:provider/provider.dart';

import 'loginModel.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  UserModel user = UserModel()..getUserInformation();
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController(
      text: user.email,
    );
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => LogInModel(),
      child: Consumer<LogInModel>(builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            SizedBox(height: 60),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'メールアドレスを入れてください'),
                      controller: mailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "メールアドレスを入れてください";
                        }
                      },
                      onChanged: (text) {
                        model.mail = text;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'パスワード'),
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "パスワードを入れてください";
                        }
                      },
                      onChanged: (text) {
                        model.password = text;
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                        child: Text('ログインする'),
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                            fixedSize: Size(150.0, 50.0),
                            primary: Color.fromARGB(255, 137, 27, 39)
                                .withOpacity(0.5)),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            _formKey.currentState!.save();
                            try {
                              await model.logIn();
                              print('成功！！！');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopPage()),
                                  (_) => false);
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
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }
                        }),
                  ],
                )),
            SizedBox(height: 50.0),
            TextButton(
              child: const Text('会員登録はこちら'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
                primary: Colors.blue[700],
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                )
              },
            ),
            SizedBox(height: 50.0),
          ]),
        );
      }),
    );
  }
}
