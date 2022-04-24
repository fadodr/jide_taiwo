import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/screens/change_password_screen.dart';
import 'package:jidetaiwoapp/screens/edit_profile_screen.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/client_dashboard_menu_drawer.dart';

class AgentSettingScreen extends StatelessWidget {
  const AgentSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
              fontSize: 20),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const ClientDashboradMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EditProfileScreen.routename, arguments: 'agent');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                    color: hextocolor('#FDEFED'),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Edit profile',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChangePasswordScreen.routename,
                    arguments: 'agent');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                    color: hextocolor('#FDEFED'),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
