import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:laughmaru/OrderedPage.dart';
import 'package:laughmaru/models/userModel.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';

import 'models/order_model.dart';

// ignore: must_be_immutable
class OrderForm extends StatefulWidget {
  String productName = '';
  String productPrice = '';
  OrderForm(String productName, String productPrice) {
    this.productName = productName;
    this.productPrice = productPrice;
  }
  @override
  _OrderFormState createState() {
    return _OrderFormState(productName, productPrice);
  }
}

class _OrderFormState extends State<OrderForm> {
  String productName = '';
  String productPrice = '';
  _OrderFormState(String productName, String productPrice) {
    this.productName = productName;
    this.productPrice = productPrice;
  }
  //datePicker
  var _labelText = '配達希望日を選んでください';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: getNextSaturdayDataTime(),
      firstDate: DateTime.now().add(Duration(days: 4)),
      lastDate: DateTime(2023),
      selectableDayPredicate: (DateTime date) =>
          date.weekday == 2 || date.weekday == 6 ? true : false,
    );
    if (selected != null) {
      setState(() {
        _labelText = DateFormat('yyyy-MM-dd').format(selected);
      });
    }
  }

  // timePicker
  DateTime getNextSaturdayDataTime() {
    DateTime dResult = DateTime.now();

    if (dResult.weekday != DateTime.saturday) {
      int flg = 0;
      for (int i = 0; i < 14; ++i) {
        dResult = dResult.add(Duration(days: 1));
        flg += 1;

        if (dResult.weekday == DateTime.saturday) {
          if (flg > 3) {
            break;
          }
        }
      }
    }

    return (dResult);
  }

  String _defaultValue = '指定なし';
  // リストアイテム
  List<String> _list = <String>[
    '指定なし',
    '9:00~12:00',
    '12:00~16:00',
    '16:00~20:00',
  ];
  String _text = '';

  // onChangedのイベントハンドラ定義
  void _handleChange(String newValue) {
    setState(() {
      _text = newValue;
      _defaultValue = newValue;
    });
  }

  int _defaultNum = 1;
  int _totalPrice = 0;
  // リストアイテム
  List<int> _numList = <int>[1, 2, 3, 4, 5];
  int _num = 1;

  // onChangedのイベントハンドラ定義
  void _numberChange(int newNum) {
    setState(() {
      _num = newNum;
      _defaultNum = newNum;
      _totalPrice = int.parse(productPrice) * newNum;
    });
  }

  Future<void> send(OrderModel order) async {
    final Email email = Email(
      body: order.createOrderBody(),
      subject: order.createOrderSubject(),
      recipients: ['ryotoht1203@gmail.com'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  UserModel user = UserModel()..getUserInformation();

  String customerName = '';
  String customerEmail = '';
  String customerPostal = '';
  String customerAddress = '';
  String customerTel = '';
  String deliDate = '';
  String deliTime = '';
  String other = '';

//それぞれの項目の値をへんかん同時に変数に格納しておくことでデータを取得⇨メール送信ボタンを押したら、それらのデータをモデルに格納し、送信の関数にモデルを引数として渡すことでメールを送信する
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget("ご注文確認", true),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'ご注文品：' + productName,
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 15),
                        primary: Color.fromARGB(255, 0, 151, 255),
                      ),
                      onPressed: () {
                        setState(() {
                          user = user;
                        });
                      },
                      child: const Text('自動入力')),
                  Row(
                    children: [
                      Text(
                        '個数：',
                        style: TextStyle(fontSize: 17),
                      ),
                      DropdownButton<int>(
                        value: _defaultNum,
                        onChanged: (num) => _numberChange(num!),
                        items: _numList.map<DropdownMenuItem<int>>((int value) {
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
                  TextFormField(
                    controller: TextEditingController(
                      text: user.name,
                    ),
                    decoration: InputDecoration(
                      hintText: 'お名前(例: 野菜　太郎)',
                      labelText: 'お名前',
                    ),
                    onChanged: (text) {
                      customerName = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "お名前を入れてください";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: TextEditingController(
                      text: user.email,
                    ),
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                    ),
                    onChanged: (text) {
                      customerEmail = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "メールアドレスを入れてください";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: TextEditingController(
                      text: user.tel,
                    ),
                    decoration: InputDecoration(
                      labelText: '電話番号',
                    ),
                    onChanged: (text) {
                      customerTel = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "電話番号を入れてください";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Form(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('郵便番号 : '),
                              SizedBox(width: 20),
                              Container(
                                width: 200,
                                child: TextFormField(
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '000-0000'),
                                  onChanged: (text) {},
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: TextEditingController(
                              text: user.address,
                            ),
                            decoration: InputDecoration(
                              labelText: 'お届け先住所',
                            ),
                            onChanged: (text) {
                              customerAddress = text;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "お届け先住所を入れてください";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        '日付 : ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 239, 255, 241),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: .5,
                              ),
                            ]),
                        child: IconButton(
                          icon: Icon(
                            Icons.date_range,
                            size: 30,
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(_labelText),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '時間指定 : ',
                        style: TextStyle(fontSize: 17),
                      ),
                      DropdownButton<String>(
                        value: _defaultValue,
                        onChanged: (text) => _handleChange(text!),
                        items:
                            _list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'ご要望（時間指定よりも細かく時間を指定したい場合はこの欄に記入してください）',
                    ),
                    onChanged: (text) {
                      other = text;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('ご請求金額: ¥ ', style: TextStyle(fontSize: 20)),
                      Text(
                        _totalPrice == 0
                            ? productPrice
                            : _totalPrice.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(' ', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(200.0, 80.0),
                      primary: Color.fromARGB(255, 160, 77, 77),
                    ),
                    onPressed: () {
                      if (_labelText == '配達希望日を選んでください') {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text('配達希望日を選んでください'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            });
                      } else if (_formKey.currentState!.validate()) {
                        send(OrderModel(
                          productName,
                          customerName,
                          customerEmail,
                          customerAddress,
                          DateTime.now().toString(),
                          _labelText,
                          _text,
                          other,
                          _num,
                          _totalPrice,
                        ));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderedPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('必須項目を入力してください')),
                        );
                      }
                    },
                    child: const Text('注文を確定する',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
