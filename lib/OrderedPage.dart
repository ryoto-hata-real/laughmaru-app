import 'package:flutter/material.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';

import 'TopPage.dart';

class OrderedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget('ご注文完了', false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'ご注文ありがとうございました。',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              Text(
                '''お客様からの注文を確認後、
こちらからご注文確定メールを
お送りいたします。''',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'しばらくお待ちくださいませ。',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    fixedSize: Size(250.0, 50.0),
                    primary: Color.fromARGB(255, 160, 77, 77),
                  ),
                  onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TopPage()),
                            (_) => false)
                      },
                  child: Text('トップページに戻る'))
            ],
          ),
        ),
      ),
    );
  }
}
