import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/screens/change_password_screen.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/screens/reset_password_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class EnterCodeScreen extends StatefulWidget {
  static const routename = '/entercodescreen';
  const EnterCodeScreen({Key? key}) : super(key: key);

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController _pincontroller = TextEditingController();
  String errorMessage = '';
  bool showError = false;
  bool isLoading = false;
  Map<String, dynamic> _args = {};

  @override
  void initState() {
    _pincontroller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pincontroller.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() {
      showError = false;
      isLoading = true;
    });
    try {
      String code;
      if (_args['belongsTo'].toString().toLowerCase() == 'client') {
        code = await Provider.of<Clientprovider>(context, listen: false)
            .verifycode(_pincontroller.text);
      } else {
        code = await Provider.of<Agentprovider>(context, listen: false)
            .verifycode(_pincontroller.text);
      }
      Navigator.of(context).pushNamed(ResetPasswordScreen.routename,
          arguments: {'resetToken': code, 'belongsTo': _args['belongsTo']});
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your internet connection'),
        duration: Duration(seconds: 3),
      ));
    } catch (error) {
      if (error.toString().contains('HttpException')) {
        errorMessage = error.toString().split('HttpException: ')[1];
      } else {
        errorMessage = 'An error occurred, try again later';
      }
      setState(() {
        showError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => const AppBarWidget('Check your email', null),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Enter the code you recieve to verify here so you can reset your account password.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (showError == true)
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            errorMessage.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                Container(
                  width: 100,
                  height: 40,
                  child: TextField(
                    controller: _pincontroller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          minimumSize: Size(double.infinity, 51),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ))
                    : ElevatedButtonWidget(
                        width: double.maxFinite,
                        height: 51,
                        buttonText: 'Verify',
                        borderRadius: 8,
                        ontap: _pincontroller.text.isEmpty ? null : submit,
                        textColor: Colors.white,
                        bgColor: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
