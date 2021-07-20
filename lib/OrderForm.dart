import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:laughmaru/widgets/AppBarWidget.dart';

import 'TopPage.dart';
import 'loginAndSignup/login_page.dart';

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
  var _labelText = '配達希望日付を選んでください';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: getLastSundayDataTime(),
      firstDate: DateTime(2021),
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
  DateTime getLastSundayDataTime() {
    DateTime dResult = DateTime.now();

    // 当日が日曜日ではないならば、
    // 直前の日曜日まで日付を戻していく
    if (dResult.weekday != DateTime.saturday) {
      for (int i = 0; i < 7; ++i) {
        dResult = dResult.add(Duration(days: 1));
        // 直近の未来の日曜日を求めたい場合は、下記のようにします。
        // dResult = dResult.add(Duration(days : 1));

        if (dResult.weekday == DateTime.saturday) {
          break;
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

  Future<void> send() async {
    final Email email = Email(
      body: 'body',
      subject: 'subject',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget("ご注文確認"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text(
                  'ご注文品：' + productName,
                  style: TextStyle(fontSize: 20),
                ),
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
                  decoration: InputDecoration(
                    hintText: 'お名前(例: 野菜　太郎)',
                    labelText: 'お名前',
                  ),
                  onChanged: (text) {},
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'メールアドレス',
                  ),
                  onChanged: (text) {},
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
                          decoration: InputDecoration(
                            labelText: 'お届け先住所',
                          ),
                          onChanged: (text) {},
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
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () => _selectDate(context),
                    ),
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
                  onChanged: (text) {},
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('ご請求金額: ¥ ', style: TextStyle(fontSize: 20)),
                    Text(
                      _totalPrice == 0 ? productPrice : _totalPrice.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    send();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TopPage()),
                    );
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
        ));
  }
}
