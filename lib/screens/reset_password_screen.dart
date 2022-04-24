import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routename = '/resetpasswordscreen';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showError = false;
  bool isLoading = false;
  String errorMessage = '';
  Map<String, dynamic> _args = {};

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextForm(
      String name, TextEditingController _controller, bool obscureText) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: TextStyle(fontSize: 14, color: hextocolor('#333333')),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: _controller,
          obscureText: obscureText,
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
              filled: true,
              errorMaxLines: 2,
              fillColor: hextocolor('#FAFAFA'),
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 18,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      if (name.toLowerCase() == 'password') {
                        _obscurePassword = !_obscurePassword;
                      }
                      if (name.toLowerCase() == 'confirm password') {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      }
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ))),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: hextocolor('#333333')),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field cannot be empty';
            }
            if (_passwordController.text != _confirmPasswordController.text) {
              return 'password does not match';
            }
            bool hasMinLength = value.length >= 6;
            if (!hasMinLength) {
              return 'password must be greater than 6 characters';
            }
            bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
            bool hasDigits = value.contains(RegExp(r'[0-9]'));
            bool hasLowercase = value.contains(RegExp(r'[a-z]'));
            bool hasSpecialCharacters =
                value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
            if (!(hasUppercase &&
                hasDigits &&
                hasLowercase &&
                hasSpecialCharacters)) {
              return 'password must contain lowercase, uppercase, digits and special characters';
            }
            return null;
          },
          onSaved: (value) {
            _passwordController.text = value.toString();
          },
        ),
      ],
    );
  }

  Future<void> submitform(context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      showError = false;
      isLoading = true;
    });
    try {
      if (_args['belongsTo'].toString().toLowerCase() == 'client') {
        await Provider.of<Clientprovider>(context, listen: false)
            .resetpassword(_args['resetToken'], _passwordController.text);
      } else {
        await Provider.of<Agentprovider>(context, listen: false)
            .resetpassword(_args['resetToken'], _passwordController.text);
      }
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: AlertDialog(
                actionsPadding: EdgeInsets.all(10),
                title: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('You have successfully reset your password',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center),
                  ],
                ),
                actions: [
                  ElevatedButtonWidget(
                      width: double.infinity,
                      height: 51,
                      buttonText: 'Take me to Home',
                      borderRadius: 8,
                      ontap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/homescreen', (Route<dynamic> route) => false);
                      },
                      textColor: Colors.white,
                      bgColor: Colors.green),
                ],
              ),
            );
          });
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your internet connection'),
        duration: Duration(seconds: 3),
      ));
    } catch (error) {
      print(error);
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
          builder: (context) => const AppBarWidget('Reset Password'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Choose a New Password',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
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
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                _buildTextForm(
                    'Password', _passwordController, _obscurePassword),
                SizedBox(
                  height: 20,
                ),
                _buildTextForm('Confirm Password', _confirmPasswordController,
                    _obscureConfirmPassword),
                const SizedBox(
                  height: 50,
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
                        width: double.infinity,
                        height: 51,
                        buttonText: 'Reset Password',
                        borderRadius: 8,
                        ontap: () => submitform(context),
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
