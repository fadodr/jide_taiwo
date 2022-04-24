import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarTwoWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const AppBarTwoWidget(@required this.title, @required this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      leading:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => onTap(),
          child: SvgPicture.asset(
            'assets/icons/Frame2.svg',
          ),
        ),
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
