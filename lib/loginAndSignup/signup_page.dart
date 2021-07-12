import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:laughmaru/loginAndSignup/signupModel.dart';
import 'package:laughmaru/models/ProductListModel.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';
import 'package:laughmaru/widgets/ProductWidget.dart';
import 'package:provider/provider.dart';

import '../FireBase.dart';
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
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(7,
          errorText: 'password must be at least 8 digits long')
    ]);
    final nameController = TextEditingController();
    final mailController = TextEditingController();
    final addressController = TextEditingController();
    final telController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBarWidget('新規登録'),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'お名前(例: 野菜　太郎)',
                      labelText: 'お名前',
                    ),
                    controller: nameController,
                    onChanged: (text) {
                      model.name = text;
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '住所',
                      labelText: '住所',
                    ),
                    controller: addressController,
                    onChanged: (text) {
                      model.address = text;
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: '電話番号'),
                    controller: telController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      model.tel = text;
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: 'メールアドレス'),
                    controller: mailController,
                    onChanged: (text) {
                      model.mail = text;
                    },
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'パスワード',
                        labelText: 'パスワード（７文字以上に設定してください）',
                      ),
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: passwordValidator,
                      onChanged: (text) {
                        model.password = text;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    child: Text(
                      '登録する',
                      style: TextStyle(color: Color.fromARGB(255, 160, 77, 77)),
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
                      try {
                        await model.signUp();
                        print('成功！！！');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TopPage()),
                        );
                      } catch (e) {
                        print('失敗');
                      }
                    },
                  )
                ],
              )),
        );
      }),
    );
  }
}
