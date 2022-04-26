import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';

class AuctionScreen extends StatelessWidget {
  static const routename = '/auctionscreen';
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget('Auctions', null),
      ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: const Image(image: AssetImage('assets/images/onb3img.png'))),
            ),
            Expanded(child: Text('Coming soon...', style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 24,
              color: hextocolor('#A9A3A3')
            ),))
          ],
        ),
      )
    );
  }
}
