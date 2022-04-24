import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/widgets/agent_dashboard/agent_home_screen.dart';
import 'package:jidetaiwoapp/widgets/agent_dashboard/agent_profile_screen.dart';
import 'package:jidetaiwoapp/widgets/agent_dashboard/agent_settings_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AgentdashboardScreen extends StatefulWidget {
  static const routename = '/mydashboardscreen';
  const AgentdashboardScreen({Key? key}) : super(key: key);

  @override
  State<AgentdashboardScreen> createState() => _AgentdashboardScreenState();
}

class _AgentdashboardScreenState extends State<AgentdashboardScreen> {
  final List<Widget> _screenToDispaly = [
    const AgentHomeScreen(),
    const AgentSettingScreen(),
    const AgentProfileScreen(),
  ];
  int navigationBarCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget((index) {
        setState(() {
          if(index != 3){
            navigationBarCurrentIndex = index;
          }   
        });
      }, navigationBarCurrentIndex, 'agent'),
      body: _screenToDispaly[navigationBarCurrentIndex]
      //bottomNavigationBar: const BottomNavigationWidget()
    );
  }
}
