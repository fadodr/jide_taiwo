import 'package:flutter/material.dart';

class AppBarDashboardWidget extends StatelessWidget {
  final String title;

  const AppBarDashboardWidget(this.title, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            fontSize: 20),
      ),
    );
  }
}
