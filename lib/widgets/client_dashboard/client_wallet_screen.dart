import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/client_dashboard_menu_drawer.dart';

class ClientWalletScreen extends StatelessWidget {
  const ClientWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget('My Wallet', () {
            Scaffold.of(context).openDrawer();
          }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const ClientDashboradMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Center(
          child: Text('Coming soon...',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 24, color: hextocolor('#A9A3A3'))),
        ),
      ),
    );
  }
}
