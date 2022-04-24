import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/screens/entercode_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routename = '/forgotpasswordscreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String errorMessage = '';
  TextEditingController _emailController = TextEditingController();
  bool showError = false;
  bool isLoading = false;
  Map<String, dynamic> _args = {};

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() {
      showError = false;
      isLoading = true;
    });
    try {
      if (_args['belongsTo'].toString().toLowerCase() == 'client') {
        await Provider.of<Clientprovider>(context, listen: false)
            .forgetpassword(_emailController.text);
      } else {
        await Provider.of<Agentprovider>(context, listen: false)
            .forgetpassword(_emailController.text);
      }
      Navigator.of(context).pushNamed(EnterCodeScreen.routename,
          arguments: {'belongsTo': _args['belongsTo']});
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
          builder: (context) => const AppBarWidget('Forget Password'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We’ll send a 4 digit code to the email address associated with your account. ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (showError == true)
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            errorMessage.toString(),
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.red)),
                      labelText: 'Email Address',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                      filled: true,
                      fillColor: hextocolor('#FAFAFA'),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20)),
                ),
                const SizedBox(
                  height: 30,
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
                        buttonText: 'Continue',
                        borderRadius: 8,
                        ontap: submit,
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
