import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_dashboard_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/screens/agent_dashboard_screen.dart';
import 'package:jidetaiwoapp/screens/client_dashboard_screen.dart';
import 'package:jidetaiwoapp/screens/forgot_password_screen.dart';
import 'package:jidetaiwoapp/screens/signup_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/loginscreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  final _formkey = GlobalKey<FormState>();
  final _focusNode = {'email': FocusNode(), 'password': FocusNode()};
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showError = false;
  String? errormessage;
  bool _obscurepassword = true;
  bool runOnce = true;
  bool showsignupsuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(String appbarText) async {
    final isvalid = _formkey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _formkey.currentState!.save();
    FocusScope.of(context).unfocus();
    setState(() {
      showError = false;
      showsignupsuccess = false;
      isloading = true;
    });
    try {
      if (appbarText.toLowerCase() == 'client') {
        await Provider.of<Clientprovider>(context, listen: false)
            .loginuser(_emailController.text, _passwordController.text);
        final clientId = Provider.of<Clientprovider>(context, listen: false)
            .getClient
            .clientId;
        await Provider.of<ClientDashboardProvider>(context, listen: false)
            .fetchClientDashboardInformation(int.parse(clientId!));
        Navigator.of(context).pushNamed(ClientDashboardScreen.routename);
      } else {
        await Provider.of<Agentprovider>(context, listen: false)
            .loginuser(_emailController.text, _passwordController.text);
        final agentId = Provider.of<Agentprovider>(context, listen: false)
            .getAgent
            .clientId;
        Navigator.of(context)
            .pushNamed(AgentdashboardScreen.routename, arguments: agentId);
        //Navigator.of(context).pushNamed(AgentdashboardScreen.routename, arguments: agentId);
      }
    } on SocketException catch (_) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your internet connection'),
        duration: Duration(seconds: 3),
      ));
    } catch (error) {
      if (error.toString().contains('HttpException')) {
        errormessage = error.toString().split('HttpException: ')[1];
      } else {
        errormessage = 'An error occurred, try again later';
      }
      setState(() {
        showError = true;
        _passwordController.clear();
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (runOnce) {
      showsignupsuccess = _args['justSignUp'] ?? false;
      runOnce = false;
    }
    Widget _inputForm(String label, TextEditingController _controller) {
      return TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        textInputAction: label.trim().toLowerCase() == 'password'
            ? TextInputAction.done
            : TextInputAction.next,
        focusNode: _focusNode[label],
        onSaved: (value) {
          if (label.trim().toLowerCase() == 'password') {
            _passwordController.text = value.toString();
          }
          if (label.trim().toLowerCase() == 'email') {
            _emailController.text = value.toString();
          }
        },
        obscureText:
            label.toLowerCase() == 'password' ? _obscurepassword : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
          filled: true,
          fillColor: hextocolor('#FAFAFA'),
          prefixIcon: label.trim().toLowerCase() == 'email'
              ? Icon(
                  Icons.mail_outline,
                  size: 18,
                )
              : Icon(
                  Icons.lock_outline,
                  size: 18,
                ),
          suffixIcon: label.toLowerCase() == 'password'
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _obscurepassword = !_obscurepassword;
                    });
                  },
                  icon: Icon(
                    _obscurepassword ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ))
              : null,
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
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field cannot be empty';
          }
          return null;
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) =>
              AppBarWidget('${_args['appbarText'].toUpperCase()} LOGIN'),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Please fill in the following to Login',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (showsignupsuccess == true)
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              'You have successfully signed up! you can now login with your credentials',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (showError == true)
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              errormessage.toString(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  _inputForm('Email', _emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  _inputForm('Password', _passwordController),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ForgotPasswordScreen.routename,
                            arguments: {'belongsTo': _args['appbarText']});
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  isloading
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
                          buttonText: 'Login',
                          borderRadius: 8,
                          ontap: () => loginUser(_args['appbarText']),
                          textColor: Colors.white,
                          bgColor: Theme.of(context).primaryColor),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                        children: [
                          const TextSpan(text: 'New user ? Click '),
                          TextSpan(
                              text: 'Here',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                        .popAndPushNamed(SignupScreen.routename,
                                            arguments: {
                                          'appbarText': _args['appbarText']
                                        }),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          const TextSpan(text: ' to Sign Up')
                        ]),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
