import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  AppBarWidget(this.title);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Icon(
      //   Icons.menu,
      //   color: Colors.black30,
      // ),
      elevation: 0,
      centerTitle: true,
      title: SizedBox(
        width: 1000,
        child: Text(
          title,
          style: TextStyle(
            color: Color.fromARGB(255, 160, 77, 77),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black38,
          ),
          onPressed: () => {},
        ),
      ],
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
