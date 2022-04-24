import 'package:flutter/material.dart';

class AppBarTwoWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const AppBarTwoWidget(this.title, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      leading:  Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(onPressed: () => onTap(), icon: Icon(Icons.menu, size: 32,))
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            fontSize: 20),
      ),
      actions: [Container()],
    );
  }
}
