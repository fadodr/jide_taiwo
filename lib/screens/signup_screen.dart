import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/model/account_type_model.dart';
import 'package:jidetaiwoapp/model/agent_model.dart';
import 'package:jidetaiwoapp/model/client_model.dart';
import 'package:jidetaiwoapp/provider/account_type_provider.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/screens/Terms_and_condition.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routename = '/signuupscreen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? checkboxValue = false;
  final _formkey = GlobalKey<FormState>();
  bool showError = false;
  String errorMessage = '';
  bool isLoading = false;
  bool _obscurepassword = true;
  bool _obscureconfirmpassword = true;
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController mobilenumbercontroller = TextEditingController(); 
  final  TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();
  AccountType? currentlyselected;


  @override
  void dispose() {
    fullnamecontroller.dispose();
    emailcontroller.dispose();
    mobilenumbercontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }
  Client _client = Client(
      clientId: '',
      clientName: '',
      phoneNumber: '',
      emailAddress: '',
      clientCategory: null,
      clientAddress: '',
      clientDistrict: '',
      clientState: '',
      lastLogin: DateTime.now());

  Agent _agent = Agent(
      clientId: '',
      clientName: '',
      clientMobileNumber: '',
      clientEmail: '',
      clientCategory: null,
      clientAddress: '',
      clientDistrict: '',
      clientState: '');

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void signupUser(String appbarText) async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    FocusScope.of(context).unfocus();
    setState(() {
      showError = false;
      isLoading = true;
    });
    if (checkboxValue == false) {
      errorMessage =
          'You have to agree to our terms and condition before you can sign up';
      setState(() {
          showError = true;
          isLoading = false;
        });
    } else {
      errorMessage = '';
      try {
        if (appbarText.toLowerCase() == 'client') {
          await Provider.of<Clientprovider>(context, listen: false)
              .signupUser(_client, passwordcontroller.text);
          Navigator.of(context).popAndPushNamed(LoginScreen.routename,
              arguments: {'justSignUp': true, 'appbarText': 'client'});
        } else {
          await Provider.of<Agentprovider>(context, listen: false)
              .signupUser(_agent, passwordcontroller.text);
          Navigator.of(context).popAndPushNamed(LoginScreen.routename,
              arguments: {'justSignUp': true, 'appbarText': 'agent'});
        }
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
  }

  Widget _inputForm(
      String appbarText, String label, TextEditingController controller, bool obscureText) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
          filled: true,
          fillColor: hextocolor('#FAFAFA'),
          errorMaxLines: 2,
          prefixIcon: label.trim().toLowerCase() == 'email'
              ? Icon(
                  Icons.mail_outline,
                  size: 18,
                )
              : label.trim().toLowerCase() == 'password' || label.toLowerCase() == 'confirm password'
                  ? Icon(
                      Icons.lock_outline,
                      size: 18,
                    )
                  : null,
          suffixIcon: label.toLowerCase() == 'password' || label.toLowerCase() == 'confirm password'
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      if (label.toLowerCase() == 'password') {
                        _obscurepassword = !_obscurepassword;
                      }
                      if (label.toLowerCase() == 'confirm password') {
                        _obscureconfirmpassword = !_obscureconfirmpassword;
                      }
                    });
                  },
                  icon: Icon(
                      obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 18))
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
              borderSide: const BorderSide(color: Colors.blue)),
        ),
        obscureText: obscureText,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field cannot be empty';
          }
          if ((label.toLowerCase() == 'password' &&
                    passwordcontroller.text !=
                        confirmpasswordcontroller.text) ||
                label.toLowerCase() == 'confirm password' &&
                    passwordcontroller.text !=
                        confirmpasswordcontroller.text) {
              return 'password does not match';
            }
          if (label.toLowerCase() == 'password' || label.toLowerCase() == 'confirm password') {
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
          }
          return null;
        },
        onChanged: (value) {
          if (appbarText.toLowerCase() == 'client') {
            _client = Client(
                clientId: _client.clientId,
                clientName: label.toString().toLowerCase() == 'full name'
                    ? value
                    : _client.clientName,
                phoneNumber: label.toString().toLowerCase() == 'mobile number'
                    ? value
                    : _client.phoneNumber,
                emailAddress: label.toString().toLowerCase() == 'email'
                    ? value
                    : _client.emailAddress,
                clientCategory: _client.clientCategory,
                clientAddress: _client.clientAddress,
                clientDistrict: _client.clientDistrict,
                clientState: _client.clientState,
                lastLogin: _client.lastLogin);
          } else {
            _agent = Agent(
                clientId: _agent.clientId,
                clientName: label.toString().toLowerCase() == 'full name'
                    ? value
                    : _agent.clientName,
                clientMobileNumber:
                    label.toString().toLowerCase() == 'mobile number'
                        ? value
                        : _agent.clientMobileNumber,
                clientEmail: label.toString().toLowerCase() == 'email'
                    ? value
                    : _agent.clientEmail,
                clientCategory: _agent.clientCategory,
                clientAddress: _agent.clientAddress,
                clientDistrict: _agent.clientDistrict,
                clientState: _agent.clientState);
          }
        },
        onSaved: (value) {
          if (appbarText.toLowerCase() == 'client') {
            _client = Client(
                clientId: _client.clientId,
                clientName: label.toString().toLowerCase() == 'full name'
                    ? value
                    : _client.clientName,
                phoneNumber: label.toString().toLowerCase() == 'mobile number'
                    ? value
                    : _client.phoneNumber,
                emailAddress: label.toString().toLowerCase() == 'email'
                    ? value
                    : _client.emailAddress,
                clientCategory: _client.clientCategory,
                clientAddress: _client.clientAddress,
                clientDistrict: _client.clientDistrict,
                clientState: _client.clientState,
                lastLogin: _client.lastLogin);
          } else {
            _agent = Agent(
                clientId: _agent.clientId,
                clientName: label.toString().toLowerCase() == 'full name'
                    ? value
                    : _agent.clientName,
                clientMobileNumber:
                    label.toString().toLowerCase() == 'mobile number'
                        ? value
                        : _agent.clientMobileNumber,
                clientEmail: label.toString().toLowerCase() == 'email'
                    ? value
                    : _agent.clientEmail,
                clientCategory: _agent.clientCategory,
                clientAddress: _agent.clientAddress,
                clientDistrict: _agent.clientDistrict,
                clientState: _agent.clientState);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _dropDownList =
        Provider.of<AccountTypeProvider>(context, listen: false).getaccountType;
    fullnamecontroller.text = _args['appbarText'].toLowerCase() == 'client'
                            ? _client.clientName!
                            : _agent.clientName!;
    emailcontroller.text = _args['appbarText'].toLowerCase() == 'client'
                            ? _client.emailAddress!
                            : _agent.clientEmail!;
    mobilenumbercontroller.text = _args['appbarText'].toLowerCase() == 'client'
                            ? _client.phoneNumber!
                            : _agent.clientMobileNumber!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) =>
              AppBarWidget('${_args['appbarText'].toUpperCase()} SIGN UP', null),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Text(
                  'Please fill in the following to Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
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
                _inputForm(
                    _args['appbarText'],
                    'Full name',
                    fullnamecontroller
                    ,false),
                const SizedBox(
                  height: 20,
                ),
                _inputForm(
                    _args['appbarText'],
                    'Mobile number',
                    mobilenumbercontroller,false),
                const SizedBox(
                  height: 20,
                ),
                _inputForm(
                    _args['appbarText'],
                    'Email',
                    emailcontroller, false),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<AccountType>(
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'please select one';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: hextocolor('#FAFAFA'),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white)),
                  ),
                  iconEnabledColor: Theme.of(context).primaryColor,
                  value: currentlyselected,
                  hint: Text(
                    'Account type',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
                  ),
                  isExpanded: true,
                  items: _dropDownList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.name?.toString() ?? '',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16, color: hextocolor('#5E5B5B')),
                      ),
                    );
                  }).toList(),
                  onSaved: (value) {
                    if (_args['appbarText'].toLowerCase() == 'client') {
                      _client = Client(
                          clientId: _client.clientId,
                          clientName: _client.clientName,
                          phoneNumber: _client.phoneNumber,
                          emailAddress: _client.emailAddress,
                          clientCategory: value?.id.toString(),
                          clientAddress: _client.clientAddress,
                          clientDistrict: _client.clientDistrict,
                          clientState: _client.clientState,
                          lastLogin: _client.lastLogin);
                    } else {
                      _agent = Agent(
                          clientId: _agent.clientId,
                          clientName: _agent.clientName,
                          clientMobileNumber: _agent.clientMobileNumber,
                          clientEmail: _agent.clientEmail,
                          clientCategory: value?.id.toString(),
                          clientAddress: _agent.clientAddress,
                          clientDistrict: _agent.clientDistrict,
                          clientState: _agent.clientState);
                    }
                  },
                  onChanged: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      currentlyselected = value;
                    });
                    if (_args['appbarText'].toLowerCase() == 'client') {
                      _client = Client(
                          clientId: _client.clientId,
                          clientName: _client.clientName,
                          phoneNumber: _client.phoneNumber,
                          emailAddress: _client.emailAddress,
                          clientCategory: value?.id.toString(),
                          clientAddress: _client.clientAddress,
                          clientDistrict: _client.clientDistrict,
                          clientState: _client.clientState,
                          lastLogin: _client.lastLogin);
                    } else {
                      _agent = Agent(
                          clientId: _agent.clientId,
                          clientName: _agent.clientName,
                          clientMobileNumber: _agent.clientMobileNumber,
                          clientEmail: _agent.clientEmail,
                          clientCategory: value?.id.toString(),
                          clientAddress: _agent.clientAddress,
                          clientDistrict: _agent.clientDistrict,
                          clientState: _agent.clientState);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    alignLabelWithHint: true,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
                    filled: true,
                    fillColor: hextocolor('#FAFAFA'),
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
                        borderSide: const BorderSide(color: Colors.blue)),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 5,
                  maxLines: null,
                  controller: TextEditingController(
                      text: _args['appbarText'].toLowerCase() == 'client'
                          ? _client.clientAddress
                          : _agent.clientAddress),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_args['appbarText'].toLowerCase() == 'client') {
                      _client = Client(
                          clientId: _client.clientId,
                          clientName: _client.clientName,
                          phoneNumber: _client.phoneNumber,
                          emailAddress: _client.emailAddress,
                          clientCategory: _client.clientCategory,
                          clientAddress: value,
                          clientDistrict: _client.clientDistrict,
                          clientState: _client.clientState,
                          lastLogin: _client.lastLogin);
                    } else {
                      _agent = Agent(
                        clientId: _agent.clientId,
                        clientName: _agent.clientName,
                        clientMobileNumber: _agent.clientMobileNumber,
                        clientEmail: _agent.clientEmail,
                        clientCategory: _agent.clientCategory,
                        clientAddress: value,
                        clientDistrict: _agent.clientDistrict,
                        clientState: _agent.clientState,
                      );
                    }
                  },
                  onSaved: (value) {
                    if (_args['appbarText'].toLowerCase() == 'client') {
                      _client = Client(
                          clientId: _client.clientId,
                          clientName: _client.clientName,
                          phoneNumber: _client.phoneNumber,
                          emailAddress: _client.emailAddress,
                          clientCategory: _client.clientCategory,
                          clientAddress: value,
                          clientDistrict: _client.clientDistrict,
                          clientState: _client.clientState,
                          lastLogin: _client.lastLogin);
                    } else {
                      _agent = Agent(
                          clientId: _agent.clientId,
                          clientName: _agent.clientName,
                          clientMobileNumber: _agent.clientMobileNumber,
                          clientEmail: _agent.clientEmail,
                          clientCategory: _agent.clientCategory,
                          clientAddress: value,
                          clientDistrict: _agent.clientDistrict,
                          clientState: _agent.clientState);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                _inputForm(_args['appbarText'], 'Password',
                     passwordcontroller, _obscurepassword),
                const SizedBox(
                  height: 20,
                ),
                _inputForm(_args['appbarText'], 'Confirm Password', confirmpasswordcontroller, _obscureconfirmpassword),
                const SizedBox(
                  height: 40,
                ),
                isLoading
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            minimumSize: const Size(double.infinity, 51)),
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
                        buttonText: 'Sign Up',
                        borderRadius: 8,
                        ontap: () => signupUser(_args['appbarText']),
                        textColor: Colors.white,
                        bgColor: Theme.of(context).primaryColor),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                      children: [
                        const TextSpan(
                            text: 'Already have an account ? Click '),
                        TextSpan(
                            text: 'Here',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                      .popAndPushNamed(LoginScreen.routename,
                                          arguments: {
                                        'appbarText':
                                            _args['appbarText'].toLowerCase()
                                      }),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        const TextSpan(text: ' to Log In')
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Terms and Conditions',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Please read these terms and conditions carefully before registering for Our Service.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(TermsScreen.routename);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'TERMS AND CONDITIONS',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Row(
                    children: [
                      Checkbox(
                          value: checkboxValue,
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          tristate: false,
                          onChanged: (value) {
                            setState(() {
                              checkboxValue = value;
                            });
                          }),
                      Text(
                        'I AGREE TO THESE TERMS AND CONDITIONS',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                            ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
