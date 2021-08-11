import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget(this.title, this.iconFlag);

  final String title;
  final bool iconFlag;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: iconFlag ? Colors.black12 : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 160, 77, 77),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            // ログアウト処理
            // 内部で保持しているログイン情報等が初期化される
            // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
            await FirebaseAuth.instance.signOut();
            // ログイン画面に遷移＋チャット画面を破棄
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return Home();
              }),
            );
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
