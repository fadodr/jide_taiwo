import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/client_dashboard/client_home_screen.dart';
import 'package:jidetaiwoapp/widgets/client_dashboard/client_settings_screen.dart';
import 'package:jidetaiwoapp/widgets/client_dashboard/client_wallet_screen.dart';
import 'package:jidetaiwoapp/widgets/client_dashboard/client_profile_screen.dart';

class ClientDashboardScreen extends StatefulWidget {
  static const routename = '/clientdashboardscreen';
  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  final List<Widget> _screenToDispaly = [
    const ClientHomeScreen(),
    const ClientWalletScreen(),
    const ClientSettingScreen(),
    const ClientProfileScreen()
  ];

  int navigationBarCurrentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenToDispaly[navigationBarCurrentIndex],
      bottomNavigationBar: BottomNavigationWidget((index) {
        setState(() {
          navigationBarCurrentIndex = index;
        });
      }, navigationBarCurrentIndex, 'client'),
    );
  }
}
