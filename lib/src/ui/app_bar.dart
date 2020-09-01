import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;

  const MyAppBar({
    Key key, @required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                this.title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                height: 26,
                color: Color(0xFF080F28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text("Search",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,

                    )
                  ],
                ),
              ),
              flex: 6,
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
