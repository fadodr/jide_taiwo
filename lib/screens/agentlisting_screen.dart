import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/screens/signup_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';

class AgentListingScreen extends StatelessWidget {
  static const routename = '/agenctlistingscreen';

  const AgentListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget('JIDE TAIWO & CO. ')
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const MenuMenuOneDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: hextocolor('#F6CFCD')),
                    child: const Image(
                        image:
                            AssetImage('assets/images/agentlistingmain.png')))),
            Column(
              children: [
                SizedBox(height: 20,),
            Text(
              'List your property to thousands of potential clients, find quality buyers, sellers and renters.',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                  ),
            ),
            SizedBox(height: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButtonWidget(
                    width: double.infinity,
                    height: 48,
                    bgColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    borderRadius: 10,
                    buttonText: 'Create a Free Account',
                    ontap: () {
                      Navigator.of(context).pushNamed(
                          SignupScreen.routename,
                          arguments: {'appbarText': 'agent'});
                    }),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButtonWidget(
                    width: double.infinity,
                    height: 48,
                    borderRadius: 10,
                    bgColor: Colors.white,
                    borderColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                    buttonText: 'Sign In',
                    ontap: () {
                      Navigator.of(context).pushNamed(LoginScreen.routename,
                          arguments: {'appbarText': 'agent'});
                    }),
                SizedBox(height: 15,)
              ],
            ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
