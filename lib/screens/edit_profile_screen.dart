import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/agent_model.dart';
import 'package:jidetaiwoapp/model/client_model.dart';
import 'package:jidetaiwoapp/provider/agent_provider.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import '../hextocolor.dart';

class EditProfileScreen extends StatefulWidget {
  static const routename = '/profilescreen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Agent? _agent;
  Client? _client;
  String? _option;
  bool isLoading = false;
  bool showError = false;
  String errorMessage = '';
  bool runOnce = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();

  @override
  void dispose() {
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _emailcontroller.dispose();
    _addresscontroller.dispose();
    super.dispose();
  }

  Widget _buildTextForm(String name, TextEditingController _controller) {
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
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: hextocolor('#FAFAFA'),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 14, color: hextocolor('#333333'))),
      ],
    );
  }

  Future<void> submitform(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_option.toString().toLowerCase() == 'client') {
        await Provider.of<Clientprovider>(context, listen: false).updateUser(
            name: _namecontroller.text,
            phoneNumber: _phonecontroller.text,
            email: _emailcontroller.text,
            address: _addresscontroller.text);
      } else {
        await Provider.of<Agentprovider>(context, listen: false).updateUser(
            name: _namecontroller.text,
            phoneNumber: _phonecontroller.text,
            email: _emailcontroller.text,
            address: _addresscontroller.text);
      }
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile have been updated successfully'),
        duration: Duration(seconds: 3),
      ));
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
        isLoading = false;
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _option = ModalRoute.of(context)!.settings.arguments as String;
    if (runOnce) {
      if (_option.toString().toLowerCase() == 'client') {
        _client = Provider.of<Clientprovider>(context, listen: false).getClient;
      } else {
        _agent = Provider.of<Agentprovider>(context, listen: false).getAgent;
      }
      _namecontroller = TextEditingController(
          text: _option.toString().toLowerCase() == 'client'
              ? _client!.clientName
              : _agent!.clientName);
      _emailcontroller = TextEditingController(
          text: _option.toString().toLowerCase() == 'client'
              ? _client!.emailAddress
              : _agent!.clientEmail);
      _phonecontroller = TextEditingController(
          text: _option.toString().toLowerCase() == 'client'
              ? _client!.phoneNumber
              : _agent!.clientMobileNumber);
      _addresscontroller = TextEditingController(
          text: _option.toString().toLowerCase() == 'client'
              ? _client!.clientAddress
              : _agent!.clientAddress);
      runOnce = false;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            )),
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
              fontSize: 20),
        ),
        actions: [Container()],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/watermarkimage2.png'))),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
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
                  _buildTextForm('Name', _namecontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildTextForm('Phone', _phonecontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildTextForm('Email', _emailcontroller),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildTextForm('Address', _addresscontroller),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Last Login: ${_option.toString().toLowerCase() == 'client' ? _client!.lastLogin : _agent!.clientName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontSize: 14, color: hextocolor('#A19898')),
                    ),
                  ),
                  SizedBox(height: 40,),
                  isLoading
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            minimumSize: const Size(double.infinity, 51),
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
                          buttonText: 'Edit Profile',
                          borderRadius: 8,
                          textSize: 20,
                          ontap: () => submitform(context),
                          textColor: Colors.white,
                          bgColor: Theme.of(context).primaryColor),
                ]),
              ))),
      //bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
