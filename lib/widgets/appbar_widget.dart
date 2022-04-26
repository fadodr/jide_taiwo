import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget? ontap;

  const AppBarWidget(this.title,this.ontap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: this.ontap ?? IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        )),
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
