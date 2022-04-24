import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';

class GetInTouchScreen extends StatefulWidget {
  static const routename = '/getintouchscreen';

  const GetInTouchScreen({Key? key}) : super(key: key);
  @override
  _GetInTouchScreenState createState() => _GetInTouchScreenState();
}

class _GetInTouchScreenState extends State<GetInTouchScreen> {
  final _formKey = GlobalKey<FormState>();


  void submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('submision successful'),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildTextForm(String name) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        labelText: name,
        filled: true,
        fillColor: hextocolor('#E1E1E1').withOpacity(0.2),
        labelStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28,
              )),
          title: Text(
            'Get In Touch',
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontSize: 20,
                color: hextocolor('#000000')),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          decoration: BoxDecoration(     
              image: DecorationImage(
                  image: AssetImage('assets/images/watermarkimage2.png'))),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextForm('Name'),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextForm('Email'),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextForm('Phone'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        filled: true,
                        labelText: 'Subject',
                        labelStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 14,
                                ),
                        alignLabelWithHint: true,
                        fillColor: hextocolor('#E1E1E1').withOpacity(0.2),
                      ),
                      maxLines: null,
                      minLines: 5,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButtonWidget(
                        width: double.infinity,
                        height: 45,
                        buttonText: 'Submit',
                        textSize: 16,
                        borderRadius: 10,
                        ontap: submitForm,
                        textColor: Colors.white,
                        bgColor: Theme.of(context).primaryColor)
                  ],
                )),
          ),
        ));
  }
}
