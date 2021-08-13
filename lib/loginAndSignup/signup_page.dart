import 'package:flutter/material.dart';
import 'package:laughmaru/loginAndSignup/signupModel.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:provider/provider.dart';
import '../TopPage.dart';
import '../main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final mailController = TextEditingController();
    final addressController = TextEditingController();
    final telController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordCheckController = TextEditingController();
    bool passwordCheck() {
      bool passwordCheck = false;
      if (passwordController.text == passwordCheckController.text) {
        passwordCheck = true;
      }
      return passwordCheck;
    }

    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarWidget('新規登録', false),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'お名前(例: 野菜　太郎)',
                          labelText: 'お名前',
                        ),
                        controller: nameController,
                        onChanged: (text) {
                          model.name = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'お名前を入力してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '住所',
                          labelText: '住所',
                        ),
                        controller: addressController,
                        onChanged: (text) {
                          model.address = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '都道府県からご住所を入力してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(hintText: '電話番号'),
                        controller: telController,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          model.tel = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '電話番号を入力してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'メールアドレス'),
                        controller: mailController,
                        onChanged: (text) {
                          model.mail = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'メールアドレスを入力してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'パスワード',
                          labelText: 'パスワード（７文字以上に設定してください）',
                        ),
                        controller: passwordController,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          model.password = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '設定するパスワードを入力してください';
                          } else if (value.length < 7) {
                            return 'パスワードは７文字以上に設定してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'パスワード確認',
                          labelText: 'パスワード確認（もう一度パスワードを入力してください）',
                        ),
                        controller: passwordCheckController,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          model.password = text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'もう一度パスワードを入力してください';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        child: Text(
                          '登録する',
                          style: TextStyle(
                              color: Color.fromARGB(255, 160, 77, 77)),
                        ),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          fixedSize: Size(150.0, 50.0),
                          primary: Colors.white,
                          elevation: 2.0,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passwordCheck()) {
                              try {
                                await model.signUp();
                                print('成功！！！');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopPage()),
                                );
                              } catch (e) {
                                print('失敗');
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('会員登録失敗'),
                                        content:
                                            Text('会員登録に失敗しました。値を正しく入れてください。'),
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
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('パスワードを一致させてください')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('必須項目を入力してください')),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 100),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            fixedSize: Size(250.0, 50.0),
                            primary: Color.fromARGB(255, 160, 77, 77),
                          ),
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                )
                              },
                          child: Text('ログインページへ')),
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }
}
