import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/screens/home_screen.dart';
import 'package:jidetaiwoapp/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateScreen();
    super.initState();
  }

  Future<void> navigateScreen() async {
    Future.delayed(const Duration(seconds: 8), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = prefs.getBool('seen') ?? false;

      if (_seen) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      } else {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacementNamed(OnboardingScreen.routename);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: hextocolor('#f3f3f3'),
        child: Center(child: Image.asset('assets/images/jidetaiwo.gif')),
      ),
    );
  }
}
