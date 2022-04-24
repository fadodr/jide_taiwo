import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/screens/home_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  final Function onTap;
  final int index;
  final String belongsTo;
  const BottomNavigationWidget(
      this.onTap, this.index, this.belongsTo,
      {Key? key})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: hextocolor('#585454'),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.index,
        backgroundColor: hextocolor('#FDEFED'),
        onTap: (index) => widget.onTap(index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          if (widget.belongsTo == 'client')
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_balance_wallet,
                ),
                label: 'Wallet'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
          if (widget.belongsTo == 'agent')
            BottomNavigationBarItem(
                icon: IconButton(
                  padding: EdgeInsetsDirectional.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routename);
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
                label: 'Logout'),
        ]);
  }
}
