import 'package:flutter/material.dart';
import 'package:laughmaru/models/userModel.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserModel()..getUserInformation(),
      child: Consumer<UserModel>(builder: (context, model, child) {
        return Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'ようこそ ' + model.name + ' さん',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        );
      }),
    );
  }
}
