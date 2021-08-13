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
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text('本当にログアウトしますか？'),
                    actions: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              primary: Color.fromARGB(255, 160, 77, 77)
                                  .withOpacity(0.5),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('キャンセル'),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              primary: Color.fromARGB(255, 160, 77, 77),
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return Home();
                                }),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ログアウトする'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
