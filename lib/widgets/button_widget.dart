import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final String buttonText;
  final double borderRadius;
  final Function? ontap;
  final Color? borderColor;
  final Color textColor;
  final Color bgColor;
  final double? textSize;

  const ElevatedButtonWidget(
      {required this.width,
      required this.height,
      required this.buttonText,
      required this.borderRadius,
      this.borderColor,
      this.textSize,
      required this.ontap,
      required this.textColor,
      required this.bgColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: ontap == null ? null : () => ontap!(),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: bgColor,
            side: BorderSide(color: borderColor ?? Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            minimumSize: Size(width, height)),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor, fontSize: textSize),
        ));
  }
}
